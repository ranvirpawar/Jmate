import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ShowRidePost(),
    YourRide(),
    CreateRide(),
    ChatConversation(),
    Profile(),
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
            unselectedItemColor: Colors.black.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Profile"),
          ),
        ],
      ),
    );
  }
}

class ChatConversation extends StatelessWidget {
  const ChatConversation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Chat"),
          ),
        ],
      ),
    );
  }
}

class CreateRide extends StatelessWidget {
  const CreateRide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Create Ride"),
          ),
        ],
      ),
    );
  }
}

class YourRide extends StatelessWidget {
  const YourRide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Your Ride"),
          ),
        ],
      ),
    );
  }
}

class ShowRidePost extends StatelessWidget {
  const ShowRidePost({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Show Ride Post"),
          ),
        ],
      ),
    );
  }
}
