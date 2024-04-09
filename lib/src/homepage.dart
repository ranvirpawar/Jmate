import 'package:flutter/material.dart';

import 'package:jmate/src/display.dart';
import 'package:jmate/src/postride.dart';
import 'package:jmate/src/show_ride_card/showride.dart';
import 'package:jmate/src/connect.dart';
import 'package:jmate/src/myrides.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

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
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Journey-Mate',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 0, // Remove the shadow below the AppBar
          centerTitle: true,
        ),
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
            items: [
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
            selectedItemColor: Colors.deepPurple, // Set the selected item color
            unselectedItemColor: Colors.black, // Set the unselected item color
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Text(
          'Explore Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Text(
          'Post Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class MyRideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Text(
          'My Rides',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class YouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Text(
          'You Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
