import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart%20';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jmate/auth/constants/image_strings.dart';

class ShowRidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

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
                'Journey-Mate',
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

              String dateString = data['date'] ?? '';
              String timeString = data['time'] ?? '';

              if (dateString.isEmpty || timeString.isEmpty) {
                return SizedBox.shrink();
              }

              DateTime rideDateTime;

              try {
                rideDateTime = DateTime.parse('$dateString $timeString');
              } catch (e) {
                print('Error parsing date and time: $e');
                return SizedBox.shrink();
              }

              if (rideDateTime.isBefore(now)) {
                // Ride is in the past, don't display it
                return SizedBox.shrink();
              }

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(data['driverId'])
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
                    rideId: doc.id,
                    vehicle: data['vehicle'] ??
                        '', // Pass the rideId to the PostCard widget
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
  final String rideId;
  final String vehicle; // Add rideId as a parameter

  PostCard({
    required this.username,
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.cost,
    required this.rideId,
    required this.vehicle, // Update the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PostRideCardWidget(
            username: username,
            source: source,
            destination: destination,
            date: date,
            time: time,
            vehicle: vehicle,
            cost: cost,
            rideId: rideId),
      ),
    );
  }
}

class PostRideCardWidget extends StatelessWidget {
  const PostRideCardWidget({
    super.key,
    required this.username,
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.vehicle,
    required this.cost,
    required this.rideId,
  });

  final String username;
  final String source;
  final String destination;
  final String date;
  final String time;
  final String vehicle;
  final double cost;
  final String rideId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 25.0,
              color: Colors.black,
            ),
            const SizedBox(width: 4.0),
            Text(
              '${username ?? ''}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Join me from ${(source).toUpperCase() ?? ''}to ${(destination).toUpperCase() ?? ''}',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 16.0,
              color: Color.fromRGBO(195, 54, 2, 1),
            ),
            const SizedBox(width: 4.0),
            Text(
              DateFormat('EEE, MMM d, yyyy').format(DateTime.parse(date ?? '')),
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            const Icon(Icons.access_time, size: 16.0),
            const SizedBox(width: 4.0),
            Text(
              DateFormat('hh:mm a')
                  .format(DateTime.parse('${date ?? ''} ${time ?? ''}')),
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Icon(Icons.directions_car, size: 16.0),
            const SizedBox(width: 4.0),
            Text(
              'Vehicle: ${vehicle ?? ''}',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Icon(Icons.currency_rupee, size: 16.0),
            const SizedBox(width: 4.0),
            Text(
              'Cost: ₹ ${cost.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () async {
                User? currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  String userId = currentUser.uid;
                  String connectRideId = rideId;

                  try {
                    DocumentSnapshot rideSnapshot = await FirebaseFirestore
                        .instance
                        .collection('postride')
                        .doc(connectRideId)
                        .get();
                    Map<String, dynamic> rideData =
                        rideSnapshot.data() as Map<String, dynamic>;

                    String source = rideData['source'] ?? '';
                    String destination = rideData['destination'] ?? '';
                    String date = rideData['date'] ?? '';
                    String driverId = rideData['driverId'] ?? '';

                    FirebaseFirestore.instance.collection('bookRide').add({
                      'userId': currentUser.uid,
                      'rideId': connectRideId,
                      'source': source,
                      'destination': destination,
                      'date': date,
                      'driverId': driverId,
                      'username': username,
                    });

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Connect request sent!'),
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
                          title: const Text('Error'),
                          content: const Text(
                            'An error occurred while creating the connection.',
                          ),
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
              child: const Row(
                children: [
                  Text(
                    'Connect',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.hail,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
