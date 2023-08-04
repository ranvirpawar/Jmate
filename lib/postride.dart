import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class PostRidePage extends StatefulWidget {
  @override
  _PostRidePageState createState() => _PostRidePageState();
}

class _PostRidePageState extends State<PostRidePage> {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _rideCostController = TextEditingController();

  User? _currentUser;
  DateTime? _selectedDate;
  DateTime? _minimumDate;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _setMinimumDate();
  }

  Future<void> _fetchCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  void _setMinimumDate() {
    final now = DateTime.now();
    _minimumDate = DateTime(now.year, now.month, now.day);
  }

  void _postRide() {
    if (_currentUser != null) {
      String userId = _currentUser!.uid;
      String source = _sourceController.text;
      String destination = _destinationController.text;
      String date = _dateController.text;
      int seats = int.tryParse(_seatsController.text) ?? 0;
      double rideCost = double.tryParse(_rideCostController.text) ?? 0.0;

      FirebaseFirestore.instance.collection('postride').add({
        'source': source,
        'destination': destination,
        'date': date,
        'seats': seats,
        'rideCost': rideCost,
        'driverId': userId
      }).then((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Ride posted successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Redirect to the desired page
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred while posting the ride.'),
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _sourceController,
              decoration: InputDecoration(labelText: 'Source'),
            ),
            TextFormField(
              controller: _destinationController,
              decoration: InputDecoration(labelText: 'Destination'),
            ),
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: _minimumDate!,
                  currentTime: _minimumDate!,
                  onConfirm: (date) {
                    setState(() {
                      _selectedDate = date;
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(date);
                    });
                  },
                );
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: _seatsController,
              decoration: InputDecoration(labelText: 'Available Seats'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _rideCostController,
              decoration: InputDecoration(labelText: 'Ride Cost'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _postRide,
              child: Text('Post Ride'),
            ),
          ],
        ),
      ),
    );
  }
}
