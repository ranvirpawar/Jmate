
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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