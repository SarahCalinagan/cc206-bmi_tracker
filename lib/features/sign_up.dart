import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  String? selectedGender; // To store the selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: usernameController, // Add the controller
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: emailController, // Add the controller
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: passwordController, // Add the controller
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            ListTile(
              title: Text('Gender'),
              contentPadding: EdgeInsets.all(0),
              dense: true,
              subtitle: Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      selectedGender = value;
                    },
                  ),
                  Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      selectedGender = value; //Still trying to figure out how to setstate in stateless widget.....
                    },
                  ),
                  Text('Female'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15), // Sets all sides 10 units
              height: 10.0,
              child: Center(
                child: TextField(
                  controller: dateinput,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Enter Birthdate",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // Use of intl to format date
                      dateinput.text = formattedDate;
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Get the values from the text form fields
               //ONGOING
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: SignUpPage(),
    ),
  );
}
