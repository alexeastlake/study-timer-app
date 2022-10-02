// ignore_for_file: file_names
import "dart:async";
import "../utility/Controller.dart";
import "package:flutter/material.dart";
import 'package:motion_sensors/motion_sensors.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  // !!Change later, only short time for development!!
  int studyMins = 1;
  int breakMins = 1;
  int startTime = 0;
  int time = 0;
  Timer? _timer;
  Duration duration = const Duration(seconds: 1);
  StreamSubscription? gyroListener;

  void startStudyTimer() {
    stopTimer();
    time = studyMins * 60;
    startTime = studyMins * 60;
    startGyro();
    _timer = Timer.periodic(duration, (timer) {
      if (time == 0) {
        stopTimer();
        completeStudyAlert();
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  void startBreakTimer() {
    stopTimer();
    time = breakMins * 60;
    startTime = studyMins * 60;
    _timer = Timer.periodic(duration, (timer) {
      if (time == 0) {
        stopTimer();
        completeBreakAlert();
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    stopGyro();
  }

  void startGyro() {
    motionSensors.gyroscopeUpdateInterval = 2500;

    gyroListener = motionSensors.gyroscope.listen((GyroscopeEvent event) {
      if (event.x > 0.5 || event.y > 0.5 || event.z > 0.5) {
        stopTimer();
        movementAlert();
      }
    });
  }

  void stopGyro() {
    gyroListener?.cancel();
  }

  void movementAlert() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Timer Stopped"),
          content: Text("You studied for ${100 - (time / startTime * 100).toInt()}% of your total study time."),
          actions: [
            TextButton(
              onPressed: () {Navigator.pop(context);},
              child: const Text("OK"),
            )
          ],
        );
      }
    );
  }

  void completeStudyAlert() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Study Finished"),
          content: Text("You completed this study time."),
          actions: [
            TextButton(
              onPressed: () {Navigator.pop(context);},
              child: const Text("OK"),
            )
          ],
        );
      }
    );
  }

  void completeBreakAlert() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Break Finished"),
          content: Text("You completed this break time."),
          actions: [
            TextButton(
              onPressed: () {Navigator.pop(context);},
              child: const Text("OK"),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Study"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Time Remaining:",
              style: TextStyle(
                fontSize: 25
              ),
            ),
            Text(
              "${Duration(seconds: time).inMinutes}:${time % 60}",
              style: const TextStyle(
                fontSize: 35,
              ),
            ),
            TextButton(
              onPressed: (() {
                startStudyTimer();
              }),
              child: const Text(
                "Start Studying",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: (() {
                startBreakTimer();
              }),
              child: const Text(
                "Start Break",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}