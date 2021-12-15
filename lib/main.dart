import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'package:firedart/firedart.dart';

import 'authentication.dart';
import 'connection_settings.dart';
import 'home.dart';

void main() async{
  FirebaseAuth.initialize('AIzaSyA3LxarRw6wCEAYK0EVrwMviZ_O4srwMzw', VolatileStore());
  runApp(MaterialApp(

    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth= FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    if(_auth.isSignedIn){
      return home();
    }
    else{
      return authentication();
    }
  }
}

