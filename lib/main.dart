import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/features/start.dart';

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
      home: StartPage(), // Set SignUpPage as the home screen
    );
  }
}
