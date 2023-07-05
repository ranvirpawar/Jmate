import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup_page.dart';
import 'login_page.dart';

// void main() {
//   FirebaseApp.initializeApp();

//   runApp(MyApp());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/signup',
      routes: {
        '/profile': (context) => ProfilePage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        

      },
    );
  }
}
