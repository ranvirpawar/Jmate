import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

import 'package:jmate/auth/constants/image_strings.dart';
import 'package:jmate/src/homepage.dart';

class PostRidePage extends StatefulWidget {
  @override
  _PostRidePageState createState() => _PostRidePageState();
}

class _PostRidePageState extends State<PostRidePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _rideCostController = TextEditingController();
  final List<String> _vehicleOptions = ['Bike', 'Car'];
  String _selectedVehicle = 'Car';

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

  bool _areAllFieldsFilled() {
    return _sourceController.text.isNotEmpty &&
        _destinationController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _timeController.text.isNotEmpty &&
        _seatsController.text.isNotEmpty &&
        _rideCostController.text.isNotEmpty;
  }

  void _postRide() {
    if (_currentUser != null) {
      String userId = _currentUser!.uid;
      String source = _sourceController.text;
      String destination = _destinationController.text;
      String date = _dateController.text;
      String time = _timeController.text;
      String vehicle = _selectedVehicle;
      int seats;

      if (vehicle == 'Bike') {
        seats = 1; // Force 1 seat for bikes
      } else {
        seats = int.tryParse(_seatsController.text) ?? 0;
      }
      double rideCost = double.tryParse(_rideCostController.text) ?? 0.0;

      FirebaseFirestore.instance.collection('postride').add({
        'source': source,
        'destination': destination,
        'date': date,
        'time': time,
        'seats': seats,
        'rideCost': rideCost,
        'driverId': userId,
        'vehicle': vehicle,
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
              ClipOval(
                child: Image(
                  image: AssetImage(travelGlobe),
                  width: 50,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Create your Journey',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        elevation: 0, // Remove the shadow below the AppBar
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStadiumTextField(
                controller: _sourceController,
                labelText: 'Source',
              ),
              SizedBox(height: 10),
              _buildStadiumTextField(
                controller: _destinationController,
                labelText: 'Destination',
              ),
              const SizedBox(height: 10),
              _buildDateInput(),
              const SizedBox(height: 10),
              _buildTimeInput(),
              const SizedBox(height: 10),
              _buildVehicleDropdown(),
              const SizedBox(height: 10),
              _buildStadiumTextField(
                controller: _rideCostController,
                labelText: 'Ride Cost',
                keyboardType: TextInputType.number,
              ),
             const  SizedBox(height: 20),
              ElevatedButton(
                onPressed: _areAllFieldsFilled() ? _postRide : null,
                child: Text('Post Ride'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStadiumTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      keyboardType: keyboardType,
      inputFormatters: keyboardType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : [], // Added input formatter
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildDateInput() {
    return InkWell(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: _minimumDate!,
          currentTime: _minimumDate!,
          onConfirm: (date) {
            setState(() {
              _selectedDate = date;
              _dateController.text = DateFormat('yyyy-MM-dd').format(date);
            });
          },
        );
      },
      child: AbsorbPointer(
        child: _buildStadiumTextField(
          controller: _dateController,
          labelText: 'Date',
        ),
      ),
    );
  }

  Widget _buildTimeInput() {
    return InkWell(
      onTap: () {
        DatePicker.showTimePicker(
          context,
          showTitleActions: true,
          showSecondsColumn: false,
          onConfirm: (time) {
            setState(() {
              _timeController.text = DateFormat('HH:mm').format(time);
            });
          },
        );
      },
      child: AbsorbPointer(
        child: _buildStadiumTextField(
          controller: _timeController,
          labelText: 'Time',
        ),
      ),
    );
  }

  Widget _buildVehicleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vehicle'),
        DropdownButtonFormField<String>(
          value: _selectedVehicle,
          items: _vehicleOptions.map((String vehicle) {
            return DropdownMenuItem<String>(
              value: vehicle,
              child: Text(vehicle),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedVehicle = newValue!;
              if (_selectedVehicle == 'Bike') {
                _seatsController.text = '1';
              } else {
                _seatsController.text = '1'; // default to 1 for car
              }
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a vehicle';
            }
            return null;
          },
        ),
        SizedBox(height: 10),
        Text('Available Seats'),
        DropdownButtonFormField<int>(
          value: int.tryParse(_seatsController.text) ?? 1,
          items: _selectedVehicle == 'Bike'
              ? [DropdownMenuItem<int>(value: 1, child: Text('1'))]
              : [
                  DropdownMenuItem<int>(value: 1, child: Text('1')),
                  DropdownMenuItem<int>(value: 2, child: Text('2')),
                  DropdownMenuItem<int>(value: 3, child: Text('3')),
                  DropdownMenuItem<int>(value: 4, child: Text('4')),
                ],
          onChanged: (int? newValue) {
            setState(() {
              _seatsController.text = newValue.toString();
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          validator: (value) {
            if (value == null || value < 1 || value > 4) {
              return 'Please select a valid number of seats';
            }
            return null;
          },
        ),
      ],
    );
  }
}
