import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql1/mysql1.dart';

import 'connection_settings.dart';

class explore extends StatefulWidget {
  final user;

  explore(this.user);
  @override
  _exploreState createState() => _exploreState();
}
class eventex{
  int event_id;
  String event_name;
  String domain_name;
  String channel_name;
  DateTime start_time;
  DateTime end_time;
  String event_platform;
  eventex(this.event_id,this.event_name,this.domain_name,this.channel_name,this.start_time,this.end_time,this.event_platform);
}

class _exploreState extends State<explore> {
  List<eventex> l=[];
  List<eventex> fl=[];
  var searchFlag = false;
  var username="loading...";
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

    getdata();
  }
  void getdata() async{
    l=[];
    fl=[];

    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select e.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.end_time,e.evant_platform from event e inner join organiser o on e.organiser_id=o.organiser_id where e.event_id not in (select event_id from registration where attendee_id=?) and e.end_time>?',[widget.user,DateTime.now().toString()]);
    conn.close();
    for(var i in r) {
      setState(() {
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[5].year,i[5].month,i[5].day,i[5].hour,i[5].minute,i[5].second);
        l.add(
            eventex(i[0],i[1], i[2], i[3],st,et,i[6]));

      });
    }
    setState(() {
      fl=List.from(l);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white70,
        actions: [
          TextButton(onPressed: (){

            getdata();
          }, child: Text('Refresh',style: TextStyle(color: Colors.black),)),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 93,
              color: Color(0xFFD3D3D3).withOpacity(.84),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 60, 10),
              child: Text(
                "EXPLORE",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 60, 20),
              child: Text(
                "Find all the webinars, below.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),

            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 60, 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        !searchFlag
                            ? Expanded(
                          child: new Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: GestureDetector(
                              child: Text(
                                'Search..',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20),
                              ),
                              onTap: () {
                                print("true");
                                setState(() {
                                  searchFlag = true;
                                });
                              },
                            ),
                          ),
                        )
                            : Expanded(
                          child: new Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  fl=List.from(l.where((obj)=>obj.channel_name.toLowerCase().contains(value.toLowerCase())||obj.event_name.toLowerCase().contains(value.toLowerCase())||obj.domain_name.toLowerCase().contains(value.toLowerCase())||obj.event_platform.toLowerCase().contains(value.toLowerCase())).toList());
                                  searchFlag = true;
                                });
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.search),
                                border: InputBorder.none,
                                hintText: "Search..",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        searchFlag
                            ? Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: new IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    fl=List.from(l);
                                    searchFlag = false;
                                  });
                                }))
                            : Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                        ),

                      ],
                    ),
                  ],
                )),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: fl.length,
                padding: EdgeInsets.all(40),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 50.0 / 10.0,
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, int i) {
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
                                child: Text("Webinar on ${fl[i].event_name}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: Color.fromRGBO(128, 0, 0, 100),
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: EdgeInsets.all(1.0),
                                child: Row(children: [
                                  Text("Presented by ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(128, 0, 0, 100),
                                      )),
                                  Text("${fl[i].channel_name}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(128, 0, 0, 100),
                                          fontWeight: FontWeight.bold))
                                ]),
                              ),
                              Container(
                                padding: EdgeInsets.all(1.0),
                                child: Text("${fl[i].start_time.hour.toString()}:${fl[i].start_time.minute.toString()} - ${fl[i].end_time.hour.toString()}:${fl[i].end_time.minute.toString()}, ${fl[i].start_time.day.toString()}th ${d[fl[i].start_time.month]} ${fl[i].start_time.year}",
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
                              TextButton(
                                  child: Text("VIEW ORGANIZER'S CHANNEL"),
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          decorationColor: Colors.green))),
                              TextButton(
                                  child: Text('REGISTER'),
                                  onPressed: () async{

                                    var conn =await MySqlConnection.connect(settings);
                                    var r=await conn.query('insert into registration(event_id,attendee_id,join_status) values(?,?,?)',[fl[i].event_id,widget.user,0]);
                                    conn.close();
                                    setState(() {
                                      fl.removeAt(i);
                                      getdata();
                                      searchFlag = false;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          decorationColor: Colors.red)))
                            ])
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
