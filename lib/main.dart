import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
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
  var user="";
  var pass="";
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
      body: Center(
        child: Container(
              child: Column(
                children: [
                      TextFormField(
                        onChanged: (c){
                          setState(() {
                            user=c;
                          });
                        },
                      ),
                  TextFormField(
                    onChanged: (c){
                      setState(() {
                        pass=c;
                      });
                    },
                  ),
                  FlatButton(onPressed: (){
                    try {
                      _auth.signInWithEmailAndPassword(
                          email: user, password: pass);
                    }
                    catch(e){
                      print(e);
                    }
                  }, child: Text("submit"))
                ],
              ),
        ),
      ),
    );
  }
}


