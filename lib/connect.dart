import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConnectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String currentUserId = currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('My Rides'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookRide').snapshots(),
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
              String userId = data['userId'] ?? '';
              String rideId = data['rideId'] ?? '';

              if (userId == currentUserId) {
                return SizedBox.shrink(); // Exclude the current user's ride details
              }

              return FutureBuilder<Map<String, dynamic>>(
                future: _fetchUserData(userId, rideId),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!userSnapshot.hasData) {
                    return SizedBox.shrink();
                  }

                  Map<String, dynamic> userData = userSnapshot.data!['userData'];
                  Map<String, dynamic> postRideData = userSnapshot.data!['postRideData'];

                  return RideCard(
                    username: userData['username'] ?? '',
                    mobileNumber: userData['mobileNumber'] ?? '',
                    source: postRideData['source'] ?? '',
                    destination: postRideData['destination'] ?? '',
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserData(String userId, String rideId) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    DocumentSnapshot postRideSnapshot = await FirebaseFirestore.instance
        .collection('postRide')
        .doc(rideId)
        .get();

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    Map<String, dynamic> postRideData = postRideSnapshot.data() as Map<String, dynamic>;

    return {
      'userData': userData,
      'postRideData': postRideData,
    };
  }
}

class RideCard extends StatelessWidget {
  final String username;
  final String mobileNumber;
  final String source;
  final String destination;

  RideCard({
    required this.username,
    required this.mobileNumber,
    required this.source,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: $username'),
            SizedBox(height: 8.0),
            Text('Mobile Number: $mobileNumber'),
            SizedBox(height: 8.0),
            Text('Source: $source'),
            Text('Destination: $destination'),
          ],
        ),
      ),
    );
  }
}
