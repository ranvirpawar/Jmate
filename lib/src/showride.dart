import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart%20';
import 'package:jmate/constants/text_strings.dart';

import 'package:jmate/constants/image_strings.dart';
import 'package:jmate/src/widgets/show_ride_widgets/ride_post_card_widget.dart';

class ShowRidePage extends StatefulWidget {
  @override
  _ShowRidePageState createState() => _ShowRidePageState();
}

class _ShowRidePageState extends State<ShowRidePage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                appName,
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
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for rides',

                labelStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w900),
                prefixIcon: Icon(Icons.search,
                    color: Colors.grey[600]), // Change icon color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0), // Adjust content padding
              ),
              onChanged: (value) {
                setState(() {
                  // Trigger the filter when text changes
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('postride').snapshots(),
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

                // Filter the rides based on search query
                final filteredDocs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final source = data['source']?.toLowerCase() ?? '';
                  final destination = data['destination']?.toLowerCase() ?? '';
                  final searchQuery = _searchController.text.toLowerCase();
                  return source.contains(searchQuery) ||
                      destination.contains(searchQuery);
                }).toList();

                return ListView(
                  children: filteredDocs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;

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
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          vehicle: data['vehicle'] ?? '',
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
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
