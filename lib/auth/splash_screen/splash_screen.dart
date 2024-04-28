import 'package:flutter/material.dart';
import 'dart:async';

import 'package:jmate/constants/image_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomeScreen();
  }

  Future<void> _navigateToHomeScreen() async {
    // Replace 'HomeScreen' with the name of your home screen widget
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          jMateLogo,
          width: 200,
        ),
      ),
    );
  }
}
