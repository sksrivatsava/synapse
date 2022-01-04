import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapse/analytics.dart';
import 'package:synapse/create_meet.dart';
import 'package:synapse/event_form.dart';

import 'connection_settings.dart';

class organiser_home extends StatefulWidget {
  final user;

  organiser_home(this.user);
  @override
  _organiser_homeState createState() => _organiser_homeState();
}
class event{
  String event_name;
  String domain_name;
  String start_time;
  String end_time;
  String duration;
  String event_paltform;
  String event_link;
  event(this.event_name,this.domain_name,this.start_time,this.end_time,this.duration,this.event_paltform,this.event_link);
}
class _organiser_homeState extends State<organiser_home> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  List<event> l=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void getdata() async{
    l=[];
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select * from event where organiser_id=?',[widget.user]);
    conn.close();
    for(var i in r){
      setState(() {
        l.add(event(i[2].toString(), i[3].toString(), i[4].toString(), i[5].toString(), i[6].toString(), i[8].toString(),i[7].toString()));
      });
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('organiser_home'),
      ),




          body: Container(
            padding: EdgeInsetsDirectional.all(10),
            child: ListView.builder(
                itemCount: l.length,
                itemBuilder: (context,index){
              return Card(
                child: Column(
                  children: [
                    Text(l[index].event_name),
                    Text(l[index].domain_name),
                    Text(l[index].start_time),
                    Text(l[index].end_time),
                    Text(l[index].duration),
                    Text(l[index].event_paltform),
                    Text(l[index].event_link),

                  ],
                ),
              );

            }
            ),
          ),

      drawer: Drawer(
        child: Column(
          children: [

            ListTile(
                leading: FaIcon(FontAwesomeIcons.chartArea),
                title: Text('analytics'),
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>analytics(widget.user)));
                }

            ),


            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: (){

              },

            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('signout'),
              onTap: () async{
                _auth.signOut();
                SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.remove('user');
                prefs.remove('pass');
              },
            )
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
              dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>eventform(widget.user)));
          // dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>create_meet()));
              if(r=='back'){
                getdata();
              }
        },
      ),
    );
  }
}
