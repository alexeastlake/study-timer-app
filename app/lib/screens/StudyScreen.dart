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
      body: const Text("Study screen!"),
    );
  }
}