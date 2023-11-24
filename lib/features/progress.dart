import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/components/home_drawer.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VitalityQuest'),
        backgroundColor: Color.fromARGB(255, 35, 33, 148),
        elevation: 0,
      ),
      endDrawer: HomeDrawer(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 35, 33, 148), // RGB values for dark blue
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 79, 78, 184),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'BMI Chart',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 79, 78, 184),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'BMI Progress',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
