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
  DateTime start_time;
  DateTime end_time;
  String event_platform;

  eventr(this.event_id,this.event_name,this.domain_name,this.channel_name,this.start_time,this.end_time,this.event_platform);
}
class _registered_eventState extends State<registered_event> {
  List<eventr> l=[];
  var d={
    1:"January",
    2:"February",
    3:"March",
    4:"April",
    5:"May",
    6:"June",
    7:"July",
    8:"August",
    9:"September",
    10:"October",
    11:"November",
    12:"December"
  };
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
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[7].year,i[7].month,i[7].day,i[7].hour,i[7].minute,i[7].second);
        l.add(eventr(i[0], i[1], i[2], i[3],st,et,  i[6]));

      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('past_events'),

      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 50.0 / 10.0,
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 20),
          padding: EdgeInsets.all(40),
          itemCount: l.length,
          itemBuilder: (context,i){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: 200,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(7.5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 20),
                    blurRadius: 93,
                    color: Color(0xFFD3D3D3).withOpacity(.84),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(1.0),
                          child: Text("Webinar on ${l[i].event_name}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Color.fromRGBO(128, 0, 0, 100),
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.all(1.0),
                          child: Row(children: [
                            Text("Presented by",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(128, 0, 0, 100),
                                )),
                            Text("${l[i].channel_name}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(128, 0, 0, 100),
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.all(1.0),
                          child: Text("${l[i].start_time.hour.toString()}:${l[i].start_time.minute.toString()} - ${l[i].end_time.hour.toString()}:${l[i].end_time.minute.toString()}, ${l[i].start_time.day.toString()}th ${d[l[i].start_time.month]} ${l[i].start_time.year}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(128, 0, 0, 100),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                  Spacer(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // TextButton(
                        //     child: Text("EDIT EVENT"),
                        //     onPressed: () {},
                        //     style: TextButton.styleFrom(
                        //         textStyle: TextStyle(
                        //             fontSize: 14,
                        //             fontWeight: FontWeight.bold,
                        //             decorationColor: Colors.green))),

                      ])
                ],
              ),
            );

      }),


    );
  }
}
