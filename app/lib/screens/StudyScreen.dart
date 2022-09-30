// ignore_for_file: file_names
import "dart:async";
import "../utility/Controller.dart";
import "package:flutter/material.dart";

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  // !!Change later, only short time for development!!
  int studyMins = 1;
  int breakMins = 1;
  int time = 0;
  Timer? _timer;
  Duration duration = const Duration(seconds: 1);

  void startStudyTimer() {
    stopTimer();
    time = 45 * 60;
    Controller.test();
    _timer = Timer.periodic(duration, (timer) {
      if (time == 0) {
        stopTimer();
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  void startBreakTimer() {
    stopTimer();
    time = 15 * 60;
    Controller.test();
    _timer = Timer.periodic(duration, (timer) {
      if (time == 0) {
        stopTimer();
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Study"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Time Remaining:"
            ),
            Text(
              "${Duration(seconds: time).inMinutes}:${time % 60}"
            ),
            TextButton(
              onPressed: (() {
                startStudyTimer();
              }),
              child: const Text(
                "Start Studying"
              ),
            ),
            TextButton(
              onPressed: (() {
                startBreakTimer();
              }),
              child: const Text(
                "Start Break"
              ),
            ),
          ],
        ),
      ),
    );
  }
}