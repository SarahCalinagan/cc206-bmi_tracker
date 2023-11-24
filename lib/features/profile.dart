import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/components/home_drawer.dart';
import 'package:cc206_bmi_tracker/features/log_in.dart';

class SectionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;

  SectionWidget({required this.icon, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 57, 55, 158)),
        borderRadius: BorderRadius.circular(8.0),
        color: Color.fromARGB(
            255, 57, 55, 158), // Set the background color to yellow
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              data,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
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
        title: Text('VitalityQuest'),
        backgroundColor: Color.fromARGB(255, 35, 33, 148),
        elevation: 0,
      ),
      endDrawer: HomeDrawer(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 35, 33, 148),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'PROFILE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              SectionWidget(
                icon: Icons.email,
                title: 'Email',
                data: 'email@example.com',
              ),
              SizedBox(height: 8),
              SectionWidget(
                icon: Icons.person,
                title: 'Gender',
                data: 'Female',
              ),
              SizedBox(height: 8),
              SectionWidget(
                icon: Icons.cake,
                title: 'Birthday',
                data: 'January 1, 1990',
              ),
              SizedBox(height: 8),
              SectionWidget(
                icon: Icons.calendar_today,
                title: 'Age',
                data: '33 years',
              ),
              SizedBox(height: 36),
              ElevatedButton(
                onPressed: () {
                  _navigateToLoginPage(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.orange,
                  ),
                ),
                child: Text('Sign out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
