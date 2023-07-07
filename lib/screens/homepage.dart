import 'package:flutter/material.dart';
import 'package:jmate/booking.dart';
import 'package:jmate/display.dart';
import 'package:jmate/postride.dart';
import 'package:jmate/showride.dart';
import 'package:jmate/connect.dart';

void main() {
  runApp(Homepage());
}

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
    NotificationScreen(),
    DisplayPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Journey-Mate'),
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
                    icon: Icon(Icons.home, color: Colors.black),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.explore, color: Colors.black),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add, color: Colors.black),
                    label: 'Post',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications, color: Colors.black),
                    label: 'Notification',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person, color: Colors.black),
                    label: 'You',
                    
                  ),
                ],
              ),
            ),
          );
        },
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

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Text(
          'Notification Screen',
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
