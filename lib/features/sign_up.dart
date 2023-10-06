import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  // Defining the method to navigate to the login page
  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Tracker'),
      ),
      body: Column(
        children: [
          Text(
            'Sign Up Page Content',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true, 
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {},
            child: Text('Sign Up'),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () => _navigateToLoginPage(context),
            child: const Text(
              "Already have an accout? Log in",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
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
