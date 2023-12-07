import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/database_helper.dart';
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
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 37, 35, 122)),
        borderRadius: BorderRadius.circular(5.0),
        color: Color.fromARGB(
            255, 37, 35, 122), // Set the background color to yellow
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
              fontSize: 17,
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
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final int userId;

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    // Load user profile based on the provided userId
    Map<String, dynamic>? user =
        await DatabaseHelper.instance.queryUserById(widget.userId);
    setState(() {
      _user = user;
    });
  }

  int calculateAge(DateTime birthDate) {
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await DatabaseHelper.instance.closeDatabase();
                Navigator.of(context).pop(); // Close the dialog
                _navigateToLoginPage(context);
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

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
          color: Color.fromARGB(255, 16, 15, 94),
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
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
              ),
              SizedBox(height: 15),
              if (_user != null) ...[
                Text(
                  _user![DatabaseHelper.columnName],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                SectionWidget(
                  icon: Icons.email,
                  title: 'Email',
                  data: _user![DatabaseHelper.columnEmail],
                ),
                SizedBox(height: 5),
                SectionWidget(
                  icon: Icons.person,
                  title: 'Gender',
                  data: _user![DatabaseHelper.columnGender],
                ),
                SizedBox(height: 5),
                SectionWidget(
                  icon: Icons.cake,
                  title: 'Birthday',
                  data: _user![DatabaseHelper.columnDateOfBirth],
                ),
                SizedBox(height: 5),
                SectionWidget(
                  icon: Icons.calendar_today,
                  title: 'Age',
                  data: _user![DatabaseHelper.columnDateOfBirth] != null
                      ? '${calculateAge(DateTime.parse(_user![DatabaseHelper.columnDateOfBirth]))} years old'
                      : 'N/A', // You can calculate age based on the date of birth
                ),
              ] else ...[
                Text('Loading user profile...'),
              ],
              SizedBox(height: 46),
              TextButton(
                onPressed: () {
                  _confirmSignOut(context);
                },
                child: Text(
                  'SIGN OUT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
