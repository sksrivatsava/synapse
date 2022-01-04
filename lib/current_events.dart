import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'connection_settings.dart';
class current_events extends StatefulWidget {
  final user;

  current_events(this.user);
  @override
  _current_eventsState createState() => _current_eventsState();
}
class eventc{
  int event_id;
  String event_name;
  String domain_name;
  String channel_name;
  String start_time;
  String duration;
  String event_platform;
  eventc(this.event_id,this.event_name,this.domain_name,this.channel_name,this.start_time,this.duration,this.event_platform);
}

class _current_eventsState extends State<current_events> {
  List<eventc> l=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void getdata() async {
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select r.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.duration,e.evant_platform from registration r inner join event e on e.event_id=r.event_id inner join organiser o on e.organiser_id=o.organiser_id where r.attendee_id=? and e.start_time<=? and e.end_time>=?',[widget.user,DateTime.now().toString(),DateTime.now().toString()]);
    conn.close();
    for(var i in r){
      setState(() {
        l.add(eventc(i[0], i[1], i[2], i[3], i[4].toString(), i[5].toString(), i[6]));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('current_events'),
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
                  RaisedButton(
                      child: Text('join'),
                      onPressed: () async{
                        var conn =await MySqlConnection.connect(settings);
                          var r=await conn.query('update registration set join_status=? where event_id=? and attendee_id=?',[1,l[i].event_id,widget.user]);
                          conn.close();
                  })
                ],
              ),
            );

          }),
    );
  }
}
