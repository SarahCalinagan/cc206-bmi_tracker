import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/components/home_drawer.dart';
import 'package:cc206_bmi_tracker/database_helper.dart';

class MyHomePage extends StatefulWidget {
  final int userId;

  MyHomePage({required this.userId});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String heightUnit = 'cm';
  String weightUnit = 'kg';
  double height = 0.0;
  double weight = 0.0;
  double bmiResult = 0.0;
  String classification = '';
  bool isDropdownOpen = false; // Track whether the dropdown is open

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  void calculateBMI() async {
    // Retrieve the latest BMI record date from the database
    List<Map<String, dynamic>> latestRecord =
        await DatabaseHelper.instance.getBMIResults(widget.userId);

    if (latestRecord.isNotEmpty) {
      // Get the latest date from the records
      DateTime latestDate =
          DateTime.parse(latestRecord.last[DatabaseHelper.bmiColumnDate]);

      // Calculate the difference between the latest date and the current date
      Duration difference = DateTime.now().difference(latestDate);

      print('Latest Date: $latestDate');
      print('Current Date: ${DateTime.now()}');
      print('Difference in Days: ${difference.inDays}');

      // Check if the difference is less than 21 days
      if (difference.inDays < 21) {
        // Display an error message and return without calculating BMI
        print('User is not allowed to enter a new BMI record yet.');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                'You can only enter a new BMI record after 21 days from you last date.',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
    }
    setState(() {
      height = double.parse(heightController.text);
      weight = double.parse(weightController.text);

      if (heightUnit == 'inch') {
        height *= 0.0254; // Convert inches to meters
      } else if (heightUnit == 'foot') {
        height *= 0.3048; // Convert feet to meters
      } else if (heightUnit == 'cm') {
        height *= 0.01; // Convert centimeters to meters
      }

      if (weightUnit == 'pound') {
        weight *= 0.453592; // Convert pounds to kilograms
      }

      bmiResult = weight / (height * height);

      // BMI Classification
      if (bmiResult < 18.5) {
        classification = 'Underweight';
      } else if (bmiResult < 24.9) {
        classification = 'Normal weight';
      } else if (bmiResult < 29.9) {
        classification = 'Overweight';
      } else {
        classification = 'Obese';
      }
      String currentDate = DateTime.now().toIso8601String();

      // Insert BMI result into the database
      Map<String, dynamic> bmiData = {
        DatabaseHelper.bmiColumnUserId:
            widget.userId, // You need to get the userId from somewhere
        DatabaseHelper.bmiColumnHeight: height,
        DatabaseHelper.bmiColumnWeight: weight,
        DatabaseHelper.bmiColumnBmiResult: bmiResult,
        DatabaseHelper.bmiColumnClassification: classification,
        DatabaseHelper.bmiColumnDate: currentDate,
      };

      // Insert BMI result into the database
      DatabaseHelper.instance.insertBMIResult(bmiData);
    });

    // Insert BMI result into the database
  }

  Map<String, String> notes = {
    'Underweight':
        'Your BMI suggests you might need to focus on nourishing your body with nutrient-rich foods to reach a healthier weight. Consider consulting a healthcare provider to address any underlying factors contributing to your low BMI.',
    'Normal weight':
        'Maintaining a healthy weight is a positive sign, but dont forget the benefits of regular exercise and a balanced diet. Keep up the good work! A healthy weight contributes to overall well-being.',
    'Overweight':
        'Its never too late to start making healthier choices. Small changes can lead to gradual weight loss and improved health.Aim for a sustainable approach to weight management through portion control and increased physical activity.',
    'Obese':
        'Taking steps to lose excess weight can lead to reduced health risks and increased energy levels.Commit to positive changes in your daily routine to support your weight loss journey.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VitalityQuest',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 16, 15, 94),
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: HomeDrawer(userId: widget.userId),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 16, 15, 94), // RGB values for dark blue
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BMI CALCULATOR',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    buildInputContainer(
                      'Height',
                      heightController,
                      'Enter your height',
                      [
                        'cm',
                        'inch',
                        'foot',
                        'meter'
                      ], // Added 'meter' as an option
                    ),
                    SizedBox(height: 10),
                    buildInputContainer(
                      'Weight',
                      weightController,
                      'Enter your weight',
                      ['kg', 'pound'],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          height = double.parse(heightController.text);
                          weight = double.parse(weightController.text);
                        });
                        calculateBMI();
                      },
                      child: Container(
                        width: 255,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'CALCULATE',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 222, 96, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the radius as needed
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    buildResultContainer(
                      'BMI Results',
                      'BMI: ${bmiResult.toStringAsFixed(2)}\nClassification: $classification',
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    buildResultContainer(
                      'Notes',
                      notes[classification] ?? '',
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputContainer(String label, TextEditingController controller,
      String hint, List<String> units) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 37, 35, 122),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  style: TextStyle(
                    color: (hint == 'Enter your height' ||
                            hint == 'Enter your weight')
                        ? Colors.white
                        : null,
                  ),
                ),
              ),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: label == 'Height' ? heightUnit : weightUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    if (label == 'Height') {
                      heightUnit = newValue!;
                    } else {
                      weightUnit = newValue!;
                    }
                  });
                },
                onTap: () {
                  setState(() {
                    isDropdownOpen = true;
                  });
                },
                items: units.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildResultContainer(String title, String result, {Color? textColor}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 37, 35, 122),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            result,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

