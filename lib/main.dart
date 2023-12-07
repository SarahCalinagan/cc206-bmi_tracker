import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:cc206_bmi_tracker/features/start.dart';
=======
import 'package:cc206_bmi_tracker/features/sign_up.dart';
import 'package:cc206_bmi_tracker/features/log_in.dart';
>>>>>>> 2e552fe883875ed537bc5ed68301f0fb1905d2f6

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI TRACKER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(), // Set StartPage as the home screen
    );
  }
}
