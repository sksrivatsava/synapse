import 'package:flutter/material.dart';

class organiser_home extends StatefulWidget {
  final user;
  organiser_home(this.user);
  @override
  _organiser_homeState createState() => _organiser_homeState();
}

class _organiser_homeState extends State<organiser_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('organiser_home'),
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
