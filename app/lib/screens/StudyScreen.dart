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
  int studyMins = 45;
  int breakMins = 15;
  int startTime = 0;
  int time = 0;
  Timer? _timer;
  Duration duration = const Duration(seconds: 1);
  StreamSubscription? gyroListener;

  // Starts the study timer and gyro listener
  void startStudyTimer() {
    stopTimer();
    time = studyMins * 60;
    startTime = studyMins * 60;
    startGyro();
    _timer = Timer.periodic(duration, (timer) {
      if (time < 0) {
        stopTimer();
        completeStudyAlert();
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  // Starts the break timer without gyro listener
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

  // Stops the current timer and gyro listener
  void stopTimer() {
    _timer?.cancel();
    stopGyro();
  }

  // Starts the gyro listener
  void startGyro() {
    motionSensors.gyroscopeUpdateInterval = 2500;

    gyroListener = motionSensors.gyroscope.listen((GyroscopeEvent event) {
      if (event.x > 0.5 || event.y > 0.5 || event.z > 0.5) {
        stopTimer();
        movementAlert();
      }
    });
  }

  // Stops the gyro listener
  void stopGyro() {
    gyroListener?.cancel();
  }

  // Shows a dialog message when movement is detected
  void movementAlert() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Timer Stopped"),
          content: Text("You studied for ${100 - (time / startTime * 100).toInt()}% of your total study time."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Controller.addStudy(100 - (time / startTime * 100).toInt());
              },
              child: const Text("OK"),
            )
          ],
        );
      }
    );
  }

  // Shows a dialog message when the study timer finishes
  void completeStudyAlert() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Study Finished"),
          content: Text("You completed this study time."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Controller.addStudy(100);
              },
              child: const Text("OK"),
            )
          ],
        );
      }
    );
  }

  // Shows a dialog message when the break timer finishes
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

  // Displays the screen
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