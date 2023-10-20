import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cc206_bmi_tracker/features/log_in.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(95, 116, 209, 1),
      appBar: AppBar(
          backgroundColor: Colors.transparent, // Set background to transparent
          elevation: 0,
      ),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  void _navigateToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
  final TextEditingController usernameController = TextEditingController(); 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final List<String> genderOptions = ['Male', 'Female',];
  String selectedGender = 'Male';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const Text(
          'Body VitalityQuest',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
                    Container(
                      width: 175,
                      padding: const EdgeInsets.fromLTRB(65, 100, 15, 10),
                      child: GestureDetector(
                       onTap: () => _navigateToSignUpPage(context),
                        child: const Text(
                       "Log in", textAlign: TextAlign.start,
                       style: TextStyle(
                        color: Colors.white,
                         fontSize: 16,
                       
                      ),
                      ),
                    ),
                      
                    ), //Container
                    const SizedBox(
                      width: 20,
                    ), //SizedBox
                    Container(
                        width: 175,
                        padding: const EdgeInsets.fromLTRB(15, 100, 10, 10),
                        child: const Text(
                        'Sign Up',
                      style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                      color: Colors.white,
                         ),
                        ),
                   ) //Container
                  ],
        ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            height: 110,
            child: Center(
              child: TextField(
                controller: dateinput,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                  labelText: "MM/DD/YY",
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
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    dateinput.text = formattedDate;
                  }
                },
              ),
            ),
          ),
           Center(
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            dense: true,
            subtitle: DropdownButton<String>(
              value: selectedGender,
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              iconSize: 30.2,
              iconEnabledColor: Color.fromRGBO(2, 0, 88, 1),
              items: genderOptions.map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
          ),
        ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(255, 162, 38, 1) , // Background color
            ),
            child: Text('Sign Up', style: TextStyle(fontSize: 20)),
          ),
        ]
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
