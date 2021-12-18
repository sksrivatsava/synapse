// @dart=2.9
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'package:firedart/firedart.dart';
import 'package:synapse/loading.dart';

import 'auth_tool.dart';
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
  var log=false;
  var conn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    islog();
    getconnect();

  }
  void getconnect() async{
    var conn1 =await MySqlConnection.connect(settings);
    setState(() {
      conn=conn1;
    });

  }
  void islog(){
    print("nice");
    _auth.signInState.listen((event) {
      print("nice2");
      print(event);
      setState(() {
        log=event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {


  if(conn!=null) {
    if (log) {
      return home(conn);
    }
    else {
      return authentication(conn);
    }
  }
  else{
    return loading();
  }
  }
}

