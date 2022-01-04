import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'connection_settings.dart';
class registered_event extends StatefulWidget {
  final user;

  registered_event(this.user);
  @override
  _registered_eventState createState() => _registered_eventState();
}
class eventr{
  int event_id;
  String event_name;
  String domain_name;
  String channel_name;
  String start_time;
  String duration;
  String event_platform;

  eventr(this.event_id,this.event_name,this.domain_name,this.channel_name,this.start_time,this.duration,this.event_platform);
}
class _registered_eventState extends State<registered_event> {
  List<eventr> l=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DateTime.now());
    getdata();
  }
  void getdata() async{
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select r.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.duration,e.evant_platform,e.end_time from registration r inner join event e on e.event_id=r.event_id inner join organiser o on e.organiser_id=o.organiser_id where r.attendee_id=? and e.end_time<?',[widget.user,DateTime.now().toString()]);
    conn.close();
    for(var i in r){
      setState(() {
        l.add(eventr(i[0], i[1], i[2], i[3], i[4].toString(), i[5].toString(), i[6]));

      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('past_events'),

      ),
      body: ListView.builder(
          itemCount: l.length,
          itemBuilder: (context,i){
            return Card(
              child: Column(
                children: [
                  Text(l[i].event_id.toString()),
                  Text(l[i].event_name),
                  Text(l[i].domain_name),
                  Text(l[i].channel_name),
                  Text(l[i].start_time),
                  Text(l[i].event_platform),
                  Text(l[i].duration),




                ],
              ),
            );

      }),


    );
  }
}
