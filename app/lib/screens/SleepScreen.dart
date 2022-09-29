// ignore_for_file: file_names
import "package:flutter/material.dart";

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sleep"),
      ),
      body: const Text("Sleep screen!"),
    );
  }
}