import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;

  SectionWidget({required this.icon, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0), // Add padding inside the container
      margin: EdgeInsets.symmetric(
          vertical: 4.0), // Add margin around the container
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Border color
        borderRadius: BorderRadius.circular(8.0), // Optional: border radius
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center align the content
        children: <Widget>[
          Icon(icon),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              data,
              textAlign: TextAlign.right, // Align the data to the right
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('VitalityQuest',
              style: TextStyle(color: Colors.black)), // Set text color
          backgroundColor: Colors.transparent, // Set background to transparent
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Center align the content in the column
            children: <Widget>[
              SizedBox(height: 16),
              Text(
                'Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'Username',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              SectionWidget(
                icon: Icons.email,
                title: 'Email',
                data: 'email@example.com',
              ),
              SectionWidget(
                icon: Icons.person,
                title: 'Gender',
                data: 'Female',
              ),
              SectionWidget(
                icon: Icons.cake,
                title: 'Birthday',
                data: 'January 1, 1990',
              ),
              SectionWidget(
                icon: Icons.calendar_today,
                title: 'Age',
                data: '33 years',
              ),
              SizedBox(
                  height:
                      36), // Add some spacing between the sections and the button
              ElevatedButton(
                onPressed: () {
                  // Add functionality for the button click
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orange), // Orange button
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

void main() => runApp(MyApp());
