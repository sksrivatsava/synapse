import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';

class registered_event extends StatefulWidget {
  final user;
  final conn;
  registered_event(this.user,this.conn);
  @override
  _registered_eventState createState() => _registered_eventState();
}

class _registered_eventState extends State<registered_event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('regitered_events'),

      ),
      body: ListView.builder(
          itemCount: ,
          itemBuilder: (){

      }),


    );
  }
}
