import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:jmate/constants/colors.dart';
import 'package:jmate/constants/image_strings.dart';
import 'package:jmate/utils/theme/theme.dart';

class ConnectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String currentUserId = currentUser?.uid ?? '';

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
                'Connection Requests',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookRide').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No rides available');
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              String userId = data['userId'] ?? '';
              String rideId = data['rideId'] ?? '';
              String driverId = data['driverId'] ?? '';

              if (userId == currentUserId || driverId != currentUserId) {
                return const SizedBox
                    .shrink(); // Exclude non-relevant ride details
              }

              return FutureBuilder<Map<String, dynamic>>(
                future: _fetchUserData(userId, rideId),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (!userSnapshot.hasData) {
                    return const SizedBox.shrink();
                  }

                  Map<String, dynamic> userData =
                      userSnapshot.data!['userData'];
                  Map<String, dynamic> postRideData =
                      userSnapshot.data!['postRideData'];

                  return RideCard(
                    username: userData['username'] ?? '',
                    mobileNumber: userData['mobileNumber'] ?? '',
                    source: postRideData['source'] ?? '',
                    destination: postRideData['destination'] ?? '',
                    date: postRideData['date'] ?? '',
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserData(
      String userId, String rideId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    DocumentSnapshot postRideSnapshot = await FirebaseFirestore.instance
        .collection('postride')
        .doc(rideId)
        .get();

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    Map<String, dynamic> postRideData =
        postRideSnapshot.data() as Map<String, dynamic>;

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
  final String date;

  RideCard({
    required this.username,
    required this.mobileNumber,
    required this.source,
    required this.destination,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.person_outline),
                const SizedBox(width: 8.0),
                Expanded(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: '$username : ',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'is interested in your journey from',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: ' $source ',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'to',
                      style: textTheme.bodyMedium?.copyWith(),
                    ),
                    TextSpan(
                      text: ' $destination ',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'on',
                      style: textTheme.bodyMedium?.copyWith(),
                    ),
                    TextSpan(
                      text: ' $date',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ])),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Icon(Icons.person_outline),
            //     SizedBox(width: 8.0),
            //     Text('$username.'),
            //   ],
            // ),
            // const SizedBox(height: 8.0),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Icon(Icons.star_border_outlined),
            //     Expanded(
            //       child: Text(
            //           ' Is interested in your journey from $source to $destination on $date'),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 8.0),
                Text(
                  'Mobile Number: $mobileNumber',
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // card to show options : chat , accept , reject\
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // chat button
                  TextButton(
                    onPressed: () {},
                    child: Text('Chat',
                        style: TextStyle(
                            color: appRedColor, fontWeight: FontWeight.w500)),
                  ),
                  // accept button
                  TextButton(
                      onPressed: () {},
                      child: Text('Accept',
                          style: TextStyle(
                              color: appRedColor,
                              fontWeight: FontWeight.w500))),
                  // reject button
                  TextButton(
                      onPressed: () {},
                      child: Text('Reject',
                          style: TextStyle(
                              color: appRedColor,
                              fontWeight: FontWeight.w500))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
