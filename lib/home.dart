import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:synapse/attendee_home.dart';
import 'package:synapse/loading.dart';
import 'package:synapse/organiser_home.dart';

import 'connection_settings.dart';
class home extends StatefulWidget {
  // final conn;
  // home(this.conn);
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  int user=0;
  var type="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async{
    var x = await _auth.getUser();
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select * from user where email=?',[x.email]);
    conn.close();
    for(var i in r){
      setState(() {
        type=i[2];
        user=i[0];
      });
    }
    print(type);

  }
  @override
  Widget build(BuildContext context) {
    if(type=='attendee'){
      return attendee_home(user);
    }
    else if(type=='organiser'){
      return organiser_home(user);
    }
    else{
      print(type);
      return loading();
    }
  }
}
