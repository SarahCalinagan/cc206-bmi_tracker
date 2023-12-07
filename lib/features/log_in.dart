// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/features/sign_up.dart';
import 'package:cc206_bmi_tracker/features/calculator.dart';
import 'package:cc206_bmi_tracker/database_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void _navigateToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  void _navigateToCalculatorPage(BuildContext context, int userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(userId: userId),
      ),
    );
  }

  void _readDatabase(BuildContext context) async {
    await DatabaseHelper.instance.readDatabase();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // State to control the opacity of the dialog
            double opacity = 0.0;

            // Function to animate the dialog
            void animateDialog() {
              setState(() {
                opacity = 1.0;
              });

              Future.delayed(Duration(seconds: 4), () {
                Navigator.of(context).pop(); // Close the dialog after 2 seconds
              });
            }

            // Trigger the animation when the dialog is first built
            animateDialog();

            return Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(40),
                child: Opacity(
                  opacity: opacity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 50,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Login Successful!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _attemptLogin(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    Map<String, dynamic>? user =
        await DatabaseHelper.instance.queryUser(username, password);

    if (user != null) {
      _navigateToCalculatorPage(context, user['_id']);
      _showSuccessDialog(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Invalid username or password."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 19, 17, 122),
              Color.fromARGB(255, 56, 71, 158),
            ],
          ),
        ),
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 80),
                    Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'log in to access your account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 170),
                    TextField(
                      controller: usernameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: passwordController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        suffixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        _attemptLogin(context);
                      },
                      child: Container(
                        width: 275,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                    TextButton(
                      onPressed: () {
                        _navigateToSignUpPage(context);
                      },
                      child: Text(
                        'Dont have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
