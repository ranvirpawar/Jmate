import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRidesPage extends StatefulWidget {
  @override
  _MyRidesPageState createState() => _MyRidesPageState();
}

class _MyRidesPageState extends State<MyRidesPage> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posted Rides'),
      ),
      body: _currentUser != null
          ? _buildMyRidesList()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildMyRidesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('postride')
          .where('driverId', isEqualTo: _currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('You have not posted any rides.'),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            return PostCard(
              source: data['source'] ?? '',
              destination: data['destination'] ?? '',
              date: data['date'] ?? '',
              time: data['time'] ?? '',
              rideCost: (data['rideCost'] ?? 0.0).toDouble(),
              onDelete: () {
                _deleteRide(doc.id);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _deleteRide(String rideId) async {
    await FirebaseFirestore.instance
        .collection('postride')
        .doc(rideId)
        .delete();
  }
}

class PostCard extends StatelessWidget {
  final String source;
  final String destination;
  final String date;
  final String time;
  final double rideCost;
  final VoidCallback onDelete;

  PostCard({
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.rideCost,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From $source to $destination',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('Date: $date'),
                    Text('Time: $time'),
                    Text('Cost: ${rideCost.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ))
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyRidesPage(),
  ));
}
