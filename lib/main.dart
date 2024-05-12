import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:jmate/auth/sign_in/sign_in_screen.dart';
// import 'package:jmate/screens/homepage%20.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:jmate/auth/splash_screen/splash_screen.dart';
import 'package:jmate/auth/welcome_screen/welcome_screen.dart';
import 'package:jmate/src/display.dart';
import 'package:jmate/src/postride.dart';
import 'package:jmate/auth/sign_up/signup_page.dart';
import 'package:jmate/utils/theme/theme.dart';

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
      theme: AppTheme.lightTheme,
      
      initialRoute: '/splashscreen',
      routes: {
        //'/profile': (context) => ProfilePage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/display': (context) => DisplayPage(),
        '/postride': (context) => PostRidePage(),
        '/welcome': (context) => const WelcomeScreen(),
        '/splashscreen': (context) => const SplashScreen(),
      },
    );
  }
}
