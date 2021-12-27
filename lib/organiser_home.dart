import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:mysql1/mysql1.dart';
import 'package:synapse/create_meet.dart';
import 'package:synapse/event_form.dart';

import 'connection_settings.dart';

class organiser_home extends StatefulWidget {
  final user;
  final conn;
  organiser_home(this.user,this.conn);
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
    var r=await widget.conn.query('select * from event where organiser_id=?',[widget.user]);
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

      body:SafeArea(
        child: CollapsibleSidebar(
          title: 'Synapse',
          isCollapsed: false,
          avatarImg: NetworkImage('https://www.pngplay.com/wp-content/uploads/5/Webinar-Logo-Wifi-PNG.png'),
          items: [
                CollapsibleItem(text: 'Profile', icon: Icons.person, onPressed: (){},isSelected: true),
              CollapsibleItem(text: 'Signout', icon: Icons.logout, onPressed: (){

                _auth.signOut();
              }),

          ],
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
              // dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>eventform(widget.user,widget.conn)));
          dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>create_meet()));
              if(r=='back'){
                getdata();
              }
        },
      ),
    );
  }
}
