import 'package:app/SleepScreen.dart';
import 'package:app/exerciseScreen.dart';
import "package:flutter/material.dart";

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  static const List<Widget> _pageOptions = <Widget>[
    ExerciseScreen(),
    SleepScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Title Text"),
        ),
        body: Container(
          child: _pageOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              label: "Exercise",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bedtime),
              label: "Sleep",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}