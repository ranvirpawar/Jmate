// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     // Fetch user details
//     fetchUserDetails();
//   }

//   Future<void> fetchUserDetails() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       // Update the text controllers with the user's name
//       _firstNameController.text = user.displayName ?? '';
//     }
//   }

//   Future<void> updateUserProfile() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       // Update user data in the database
//       // Example: Use Firebase Realtime Database or Firestore to update user data
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Welcome ${_firstNameController.text}!', // Display the user's name
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               controller: _firstNameController,
//               decoration: InputDecoration(labelText: 'First Name'),
//             ),
//             TextFormField(
//               controller: _lastNameController,
//               decoration: InputDecoration(labelText: 'Last Name'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 updateUserProfile();
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
