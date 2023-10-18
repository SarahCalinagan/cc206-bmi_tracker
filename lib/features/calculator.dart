import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'Calculate Your BMI',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),

              // Height Input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Column(
                        children: [
                          Text('Height'),
                          Row( // Added Row for "Value" and "Unit"
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: 'Value'),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  items: <String>['cm', 'inches'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {},
                                  value: 'cm', // Set the default value
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              // Weight Input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Column(
                        children: [
                          Text('Weight'),
                          Row( // Added Row for "Value" and "Unit"
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: 'Value'),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  items: <String>['kg', 'pounds'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {},
                                  value: 'kg', // Set the default value
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.0),

              // Calculate Button
              ElevatedButton(
                onPressed: () {
                  // Implement BMI calculation logic here
                },
                child: Text('Calculate BMI'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
