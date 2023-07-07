import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'booking.dart';

class ShowRidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('postride').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No rides available');
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(data['userId'])
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!userSnapshot.hasData) {
                    return SizedBox.shrink();
                  }

                  Map<String, dynamic> userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  String username = userData['username'] ?? '';

                  return PostCard(
                    username: username,
                    source: data['source'] ?? '',
                    destination: data['destination'] ?? '',
                    date: data['date'] ?? '',
                    time: data['time'] ?? '',
                    cost: (data['rideCost'] ?? 0.0).toDouble(),
                    rideId: doc.id, // Pass the rideId to the PostCard widget
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String source;
  final String destination;
  final String date;
  final String time;
  final double cost;
  final String rideId; // Add rideId as a parameter

  PostCard({
    required this.username,
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.cost,
    required this.rideId, // Update the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${username ?? ''}'),
            SizedBox(height: 8.0),
            Text('Join me From ${source ?? ''} to ${destination ?? ''}'),
            Text('On ${date ?? ''} ${time ?? ''}'),
            Text('Cost: ${cost.toStringAsFixed(2)}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                User? currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  String userId = currentUser.uid;
                  String connectRideId =
                      rideId; // Use a different variable name to avoid shadowing

                  try {
                    FirebaseFirestore.instance
                        .collection('bookRide')
                        .add({'userId': userId, 'rideId': connectRideId});

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Success'),
                          content: Text('Connection created successfully.'),
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
                  } catch (error) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(
                              'An error occurred while creating the connection.'),
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
              },
              child: Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
