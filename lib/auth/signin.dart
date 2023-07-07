// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();

//   String _username = '';
//   String _password = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Username'),
//                 onChanged: (value) {
//                   _username = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 onChanged: (value) {
//                   _password = value;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 child: Text('Login'),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Perform login validation
//                     bool isValid = _validateCredentials();

//                     if (isValid) {
//                       // Navigate to the home page
//                       Navigator.pushReplacementNamed(context, '/home');
//                     } else {
//                       // Show an error message
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text('Login Failed'),
//                             content: Text('Invalid username or password'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Text('OK'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     }
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   bool _validateCredentials() {
//     // Predefined username and password values for validation
//     final validUsername = 'admin';
//     final validPassword = 'password';

//     // Perform the validation
//     return _username == validUsername && _password == validPassword;
//   }
// }
