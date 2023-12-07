import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cc206_bmi_tracker/features/log_in.dart';
<<<<<<< HEAD

class SignUpPage extends StatelessWidget {
<<<<<<< HEAD
<<<<<<< HEAD
  const SignUpPage({Key? key}) : super(key: key);
=======
=======
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(95, 116, 209, 1),
      appBar: AppBar(
          backgroundColor: Colors.transparent, // Set background to transparent
          elevation: 0,
      ),
      body: SignUpForm(),
    );
  }
}
>>>>>>> 2e552fe883875ed537bc5ed68301f0fb1905d2f6

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  void _navigateToSignUpPage(BuildContext context) {
=======
import 'package:cc206_bmi_tracker/features/calculator.dart';
import 'package:cc206_bmi_tracker/database_helper.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void _navigateToLoginPage(BuildContext context) {
>>>>>>> sign_up-APINAN-LAMSIN-MANUEL
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
<<<<<<< HEAD
  final TextEditingController usernameController = TextEditingController(); 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
<<<<<<< HEAD
 final String? selectedGender;
 

 SignUpPage({
    Key? key,
    this.selectedGender,
  }) : super(key: key);
>>>>>>> cfde13d1121333bc68fe72bb0370f93ec3461730

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
              'Sign Up',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
=======
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
>>>>>>> 2e552fe883875ed537bc5ed68301f0fb1905d2f6
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
=======

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

              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pop(); // Close the dialog after 2 seconds
              });
            }

            // Trigger the animation when the dialog is first built
            animateDialog();

            return Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
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
                        'Sign Up Successful!',
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

  void _navigateToCalculatorPage(BuildContext context) async {
    // Get the values from the text controllers
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String dateOfBirth = dateinput.text;
    String gender = genderController.text;

    // Create a map of user data
    Map<String, dynamic> user = {
      DatabaseHelper.columnName: username,
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.columnPassword: password,
      DatabaseHelper.columnDateOfBirth: dateOfBirth,
      DatabaseHelper.columnGender: gender,
    };

    // Insert the user into the database
    int userId = await DatabaseHelper.instance.insertUser(user);

    // Navigate to the calculator page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(userId: userId)),
    );
    Future.delayed(Duration(seconds: 1), () {
      _showSuccessDialog(context);
    });
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController genderController = TextEditingController();

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
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 80),
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'by creating an account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 80),
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
                    SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Email',
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
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextField(
                          controller: dateinput,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            labelStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              dateinput.text = formattedDate;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: genderController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        _navigateToCalculatorPage(context);
                      },
                      child: Container(
                        width: 275,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'SIGN UP',
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
                        _navigateToLoginPage(context);
                      },
                      child: Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
>>>>>>> sign_up-APINAN-LAMSIN-MANUEL
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
<<<<<<< HEAD
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
=======
          ],
        ),
      ),
>>>>>>> sign_up-APINAN-LAMSIN-MANUEL
    );
  }
}
