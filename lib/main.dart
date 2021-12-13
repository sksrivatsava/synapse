import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async{
    var settings = new ConnectionSettings(
        host: 'bk4oo8z71jnpv8f5uksk-mysql.services.clever-cloud.com',
        port: 3306,
        user: 'urqfcrvtkfsqqjag',
        password: 'KstMvgETT44ydPtKAfPY',
        db: 'bk4oo8z71jnpv8f5uksk'
    );
    var conn = await MySqlConnection.connect(settings);
    var results=await conn.query('select * from test');
    for(var row in results){
      print('${row[0]} ${row[1]}');
      print("nice");
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('synapse'),
      ),
      body: Container(

      ),
    );
  }
}


