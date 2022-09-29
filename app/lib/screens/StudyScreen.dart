// ignore_for_file: file_names
import "package:flutter/material.dart";

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

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
            const Text(
              "00:00"
            ),
            TextButton(
              onPressed: (() {
                print("Start Studying");
              }),
              child: const Text(
                "Start Studying"
              ),
            ),
            TextButton(
              onPressed: (() {
                print("Start Break");
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