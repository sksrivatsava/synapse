import 'package:flutter/material.dart';

class attendee_home extends StatefulWidget {
  final user;
  attendee_home(this.user);
  @override
  _attendee_homeState createState() => _attendee_homeState();
}

class _attendee_homeState extends State<attendee_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('attendee_home'),
      ),

      body: Container(
        child: Center(
          child: Text(
            widget.user.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 200,
            ),
          ),
        ),
      ),
    );
  }
}
