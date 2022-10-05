import 'package:app/utility/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int studyPercent = 0;
  int sleepTime = 0;

  // Clears the stats fields
  void clear() {
    Controller.clearData();

    setState(() {
      studyPercent = 0;
      sleepTime = 0;
    });
  }

  // Refreshes the stats fields from Firebase
  void refresh() {
    setState(() {
      Controller.getAverageStudyPercent().then((value) {
        studyPercent = value;
      });

      Controller.getAverageSleepTime().then((value) {
        sleepTime = value;
      });
    }); 
  }

  // Displays the screen
  @override
  Widget build(BuildContext context) {
    refresh();

    return Scaffold(
      appBar: AppBar(
          title: const Text("Stats"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Average Study % of Total:",
              style: TextStyle(
                fontSize: 25
              )
            ),
            Text(
              "$studyPercent%",
              style: const TextStyle(
                fontSize: 35
              )
            ),
            const Text(
              "Average Sleep Time:",
              style: TextStyle(
                fontSize: 25
              )
            ),
            Text(
              "${sleepTime}m",
              style: const TextStyle(
                fontSize: 35
              )
            ),
            TextButton(
              onPressed: (() {
                refresh();
              }),
              child: const Text(
                "Refresh Stats",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: (() {
                clear();
              }),
              child: const Text(
                "Clear Data",
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