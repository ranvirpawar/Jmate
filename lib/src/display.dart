import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jmate/constants/image_strings.dart';
import 'package:jmate/auth/sign_in/sign_in_screen.dart';

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
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(travelGlobe, width: 50),
              ),
              const SizedBox(width: 10),
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),

        elevation: 0, // Remove the shadow below the AppBar
      ),
      body: Center(
        child: _currentUser != null && _userDetails != null
            ? Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${_userDetails!['firstName']} ${_userDetails!['lastName']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: const Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _currentUser!.email!,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(
                        Icons.email,
                        size: 30,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _userDetails!['mobileNumber'],
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(
                        Icons.phone,
                        size: 30,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _userDetails!['username'],
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(
                        Icons.person_pin,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _logout(context),
                      child: Text('Logout'),
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
