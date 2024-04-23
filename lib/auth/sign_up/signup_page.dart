import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jmate/auth/sign_in/login_page.dart';
import 'package:jmate/auth/sign_up/signup_header_widget.dart';
import 'package:jmate/constants/image_strings.dart';
import 'package:jmate/constants/text_strings.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            form_header_widget(
                image: signUpScreenImage,
                title: signupTitle,
                subTitle: signupSubTitle),
            SizedBox(height: 16), // Adding space between fields
            TextFormFieldWithIcon(
              controller: _firstNameController,
              labelText: 'First Name',
              icon: Icons.person,
            ),
            SizedBox(height: 16), // Adding space between fields
            TextFormFieldWithIcon(
              controller: _lastNameController,
              labelText: 'Last Name',
              icon: Icons.person,
            ),
            SizedBox(height: 16), // Adding space between fields
            TextFormFieldWithIcon(
              controller: _usernameController,
              labelText: 'Username',
              icon: Icons.account_circle,
            ),
            SizedBox(height: 16), // Adding space between fields
            TextFormFieldWithIcon(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.email,
            ),
            SizedBox(height: 16), // Adding space between fields
            TextFormFieldWithIcon(
              controller: _mobileNumberController,
              labelText: 'Mobile Number',
              icon: Icons.phone,
            ),
            SizedBox(height: 16), // Adding space between fields
            TextFormFieldWithIcon(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 16), // Adding space between fields
            TextFormFieldWithIcon(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 16), // Adding space between fields
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signUp,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: alreadyHaveAnAccount,
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: login.toUpperCase(),
                        style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String username = _usernameController.text;
    String email = _emailController.text;
    String mobileNumber = _mobileNumberController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        mobileNumber.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all the fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Passwords do not match.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;
      User user = User(firstName, lastName, username, mobileNumber, password);
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(userId).set(user.toJson());

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User registered successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('An error occurred while registering the user. $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class User {
  String firstName;
  String lastName;
  String username;
  String mobileNumber;
  String password;

  User(this.firstName, this.lastName, this.username, this.mobileNumber,
      this.password);

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'mobileNumber': mobileNumber,
      'password': password,
    };
  }
}

class TextFormFieldWithIcon extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;

  TextFormFieldWithIcon({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
      ),
      obscureText: obscureText,
    );
  }
}
