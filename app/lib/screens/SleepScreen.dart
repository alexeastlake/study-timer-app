// ignore_for_file: file_names
import 'dart:async';
import "package:flutter/material.dart";
import 'package:motion_sensors/motion_sensors.dart';

import '../utility/Controller.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  int time = 0;
  Timer? _timer;
  Duration duration = const Duration(seconds: 1);
  StreamSubscription? gyroListener;

  void startSleepTimer() {
    stopTimer();
    time = 0;
    startGyro();
     _timer = Timer.periodic(duration, (timer) {
      setState(() {
        time++;
      });
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
          content: Text("You slept for ${Duration(seconds: time).inMinutes}:${time % 60}."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Controller.addSleep(Duration(seconds: time).inMinutes);
              },
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
        title: const Text("Sleep"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Time Sleeping:",
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
                startSleepTimer();
              }),
              child: const Text(
                "Start Sleeping",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: (() {
                stopTimer();
              }),
              child: const Text(
                "Stop Sleeping",
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