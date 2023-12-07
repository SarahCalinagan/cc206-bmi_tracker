import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/features/calculator.dart';
import 'package:cc206_bmi_tracker/features/profile.dart';
import 'package:cc206_bmi_tracker/features/progress.dart';
import 'package:cc206_bmi_tracker/database_helper.dart';

class HomeDrawer extends StatelessWidget {
  final int userId;

  HomeDrawer({required this.userId});

  Future<Map<String, String>> getUserDetails(int userId) async {
    try {
      final userDetails = await DatabaseHelper.instance.getUserById(userId);

      if (userDetails != null) {
        return {
          'username': userDetails['username'] ?? 'User Not Found',
          'email': userDetails['email'] ?? 'Email Not Found',
        };
      } else {
        return {'username': 'User Not Found', 'email': 'Email Not Found'};
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return {'username': 'Error', 'email': 'Error'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, String>>(
        future: getUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('User details not found');
          } else {
            var userDetails = snapshot.data ??
                {'username': 'User Not Found', 'email': 'Email Not Found'};

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 44, 17, 151),
                  ),
                  accountName: Text(
                    userDetails['username'] ?? 'Username Not Found',
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    userDetails['email'] ?? 'Email Not Found',
                    style: TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/profile_picture.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.calculate),
                    title: Text('Calculator'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(userId: userId),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(userId: userId),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.timeline),
                    title: Text('Progress'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgressPage(userId: userId),
                        ),
                      );
                    },
                  ),
                ),
                // Add more ListTile items for additional pages
              ],
            );
          }
        },
      ),
    );
  }
}
