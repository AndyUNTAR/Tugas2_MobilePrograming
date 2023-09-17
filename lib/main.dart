import 'package:flutter/material.dart';
import 'package:stopwatch/about.dart';
import 'package:stopwatch/home_screen.dart';
import 'package:stopwatch/login_screen.dart';
import 'package:stopwatch/stopwatch.dart';
import 'package:stopwatch/timer.dart';

void main() => runApp(StopwatchApp());

class StopwatchApp extends StatelessWidget {
  Widget build (BuildContext context) {
    return MaterialApp(
        home: LoginScreen(),
    );
  }
}