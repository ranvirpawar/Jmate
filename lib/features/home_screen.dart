import 'package:flutter/material.dart';
import 'package:jmate/constants/colors.dart';

import 'package:jmate/features/display.dart';
import 'package:jmate/features/postride.dart';
import 'package:jmate/features/show_ride_card/showride.dart';
import 'package:jmate/features/connect.dart';
import 'package:jmate/features/myrides.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  // list of screens to navigate through bottomnavigationbar
  final List<Widget> _screens = [
    ShowRidePage(),
    ConnectPage(),
    PostRidePage(),
    MyRidesPage(),
    DisplayPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.copyWith(
                  bodyText1: TextStyle(color: Colors.black),
                ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.near_me),
                label: 'Connect',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_car),
                label: 'MyRides',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'You',
              ),
            ],
            selectedItemColor: appBlackColor, 
            unselectedItemColor:
                Colors.black.withOpacity(0.8), 
          ),
        ),
      ),
    );
  }
}

