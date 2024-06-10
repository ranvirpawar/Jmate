import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: YouScreen(),
    );
  }
}

class YouScreen extends StatefulWidget {
  @override
  _YouScreenState createState() => _YouScreenState();
}

class _YouScreenState extends State<YouScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  void _saveData() {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final username = _usernameController.text;
    final email = _emailController.text;
    final mobileNumber = _mobileNumberController.text;

    // Save the data to Firestore
    FirebaseFirestore.instance.collection('users').add({
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'mobileNumber': mobileNumber,
    });

    // Clear the text fields
    _firstNameController.clear();
    _lastNameController.clear();
    _usernameController.clear();
    _emailController.clear();
    _mobileNumberController.clear();

    // Show a snackbar to indicate successful save
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Information saved successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _mobileNumberController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
