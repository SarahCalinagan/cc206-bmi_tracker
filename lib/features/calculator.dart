import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/components/home_drawer.dart';

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitalityQuest',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
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

  void calculateBMI() {
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
    });
  }

  Map<String, String> notes = {
    'Underweight': 'Recommendation for underweight...',
    'Normal weight': 'Recommendation for normal weight...',
    'Overweight': 'Recommendation for overweight...',
    'Obese': 'Recommendation for obesity...',
  };

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
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BMI Calculator',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                buildInputContainer(
                  'Height',
                  heightController,
                  'Enter your height',
                  ['cm', 'inch', 'foot', 'meter'], // Added 'meter' as an option
                ),
                SizedBox(height: 20),
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
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                ),
                SizedBox(height: 30),
                buildResultContainer(
                  'BMI Results',
                  'BMI: ${bmiResult.toStringAsFixed(2)}\nClassification: $classification',
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                buildResultContainer(
                  'Notes',
                  notes[classification] ?? '',
                  textColor: Colors.white,
                ),
              ],
            ),
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
        color: Color.fromARGB(255, 57, 55, 158),
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
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
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
        color: Color.fromARGB(255, 57, 55, 158),
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
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

