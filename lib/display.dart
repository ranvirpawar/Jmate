import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  User? _currentUser;
  Map<String, dynamic>? _userDetails;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _fetchUserDetails();
  }

  Future<void> _fetchCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  Future<void> _fetchUserDetails() async {
    if (_currentUser != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();
      if (snapshot.exists) {
        setState(() {
          _userDetails = snapshot.data() as Map<String, dynamic>?;
        });
      }
    }
  }// show

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _currentUser != null && _userDetails != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Name: ${_userDetails!['firstName']} ${_userDetails!['lastName']}'),
                  Text('Email: ${_currentUser!.email}'),
                  Text('Mobile Number: ${_userDetails!['mobileNumber']}'),
                  Text('Username: ${_userDetails!['username']}'),
                  // You can display other user details here
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
