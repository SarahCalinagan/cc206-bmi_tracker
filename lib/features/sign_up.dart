import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //For formatting dates
import 'package:cc206_bmi_tracker/features/log_in.dart';

class SignUpPage extends StatelessWidget {
  void _navigateToSignUpPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  //For getting input values
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final String? selectedGender;

  SignUpPage({
    Key? key,
    this.selectedGender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Tracker'),
      ),
      body: Column(
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
                  onChanged: null,
                ),
                Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: null,
                ),
                Text('Female'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15), // Sets all sides 10 units
            height: 150,
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
                    String formattedDate = DateFormat('yyyy-MM-dd')
                        .format(pickedDate); // Use of intl to format date
                    dateinput.text = formattedDate;
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {},
            child: Text('Sign Up'),
          ),
          SizedBox(height: 10),
          Center(
            child: GestureDetector(
              onTap: () => _navigateToSignUpPage(context),
              child: const Text(
                "Already have an account? Log in",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SignUpPageParent extends StatefulWidget {
  @override
  _SignUpPageParentState createState() => _SignUpPageParentState();
}

class _SignUpPageParentState extends State<SignUpPageParent> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Tracker'),
      ),
      body: SingleChildScrollView(
        child: SignUpPage(
          selectedGender: selectedGender,
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
