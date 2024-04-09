import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jmate/display.dart';
import 'package:jmate/auth/sign_in/login_page.dart';
// import 'package:jmate/screens/homepage%20.dart';
import 'profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup_page.dart';
import 'postride.dart';
import 'showride.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/login',
      routes: {
        //'/profile': (context) => ProfilePage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/display': (context) => DisplayPage(),
        '/postride': (context) => PostRidePage()
      },
    );
  }
}
