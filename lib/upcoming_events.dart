import 'package:flutter/material.dart';

class upcoming_events extends StatefulWidget {
  final user;
  final conn;
  upcoming_events(this.user,this.conn);
  @override
  _upcoming_eventsState createState() => _upcoming_eventsState();
}

class eventu{
  int event_id;
  String event_name;
  String domain_name;
  String channel_name;
  String start_time;
  String duration;
  String event_platform;
  eventu(this.event_id,this.event_name,this.domain_name,this.channel_name,this.start_time,this.duration,this.event_platform);
}
class _upcoming_eventsState extends State<upcoming_events> {
  List<eventu> l=[];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void getdata() async{
    var r=await widget.conn.query('select r.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.duration,e.evant_platform from registration r inner join event e on e.event_id=r.event_id inner join organiser o on e.organiser_id=o.organiser_id where r.attendee_id=? and e.start_time>?',[widget.user,DateTime.now().toString()]);
    for(var i in r){
      setState(() {
        l.add(eventu(i[0], i[1], i[2], i[3], i[4].toString(), i[5].toString(), i[6]));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upcoming_events'),
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
