// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();

//   String _firstName = '';
//   String _lastName = '';
//   String _username = '';
//   String _email = '';
//   String _password = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'First Name'),
//                 onChanged: (value) {
//                   _firstName = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 onChanged: (value) {
//                   _lastName = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Username'),
//                 onChanged: (value) {
//                   _username = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Email'),
//                 keyboardType: TextInputType.emailAddress,
//                 onChanged: (value) {
//                   _email = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 onChanged: (value) {
//                   _password = value;
//                 },
//               ),
//               ElevatedButton(
//                 child: Text('Sign Up'),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Create the users collection if it does not exist
//                     FirebaseFirestore.instance.collection('users').doc().set({
//                       'firstName': _firstName,
//                       'lastName': _lastName,
//                       'username': _username,
//                       'email': _email,
//                     });
//                      Navigator.of(context).pushNamed('/signin');
//                     // Show a message if the data is stored successfully or not
                    
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
