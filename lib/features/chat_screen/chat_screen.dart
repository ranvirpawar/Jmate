import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserId;
  final String receiverUsername;

  const ChatScreen({super.key, required this.receiverUserId, required this.receiverUsername});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [


          ],
        ),
      ),
    );
  }
}