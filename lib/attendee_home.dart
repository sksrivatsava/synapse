import 'package:carousel_slider/carousel_slider.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapse/calendar.dart';
import 'package:synapse/current_events.dart';
import 'package:synapse/explore.dart';
import 'package:synapse/registered_events.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synapse/upcoming_events.dart';
import 'package:url_launcher/url_launcher.dart';

import 'connection_settings.dart';

class attendee_home extends StatefulWidget {
  final user;

  attendee_home(this.user);
  @override
  _attendee_homeState createState() => _attendee_homeState();
}
class eventa{
  int event_id;
  String event_name;
  String domain_name;
  String channel_name;
  DateTime start_time;
  DateTime end_time;
  String event_platform;
  String event_link;
  eventa(this.event_id,this.event_name,this.domain_name,this.channel_name,this.start_time,this.end_time,this.event_platform,this.event_link);
}
class _attendee_homeState extends State<attendee_home> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  List<eventa> l=[];
  List<eventa> fl=[];
  List<eventa> l1=[];
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
    l1=[];
    fl=[];
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select e.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.end_time,e.evant_platform,e.event_link from event e inner join organiser o on e.organiser_id=o.organiser_id where e.domain_name in (select domain_name from domain where attendee_id=?) and e.event_id not in (select event_id from registration where attendee_id=?) and e.end_time>?',[widget.user,widget.user,DateTime.now().toString()]);

    for(var i in r) {
      setState(() {
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[5].year,i[5].month,i[5].day,i[5].hour,i[5].minute,i[5].second);
        l.add(
            eventa(i[0],i[1], i[2], i[3],st,et,i[6],i[7]));

      });
    }
    setState(() {
      fl=List.from(l);
    });
    r=await conn.query('select r.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.end_time,e.evant_platform,e.event_link from registration r inner join event e on e.event_id=r.event_id inner join organiser o on e.organiser_id=o.organiser_id where r.attendee_id=? and e.start_time<=? and e.end_time>=?',[widget.user,DateTime.now().toString(),DateTime.now().toString()]);
    for(var i in r) {
      setState(() {
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[5].year,i[5].month,i[5].day,i[5].hour,i[5].minute,i[5].second);
        l1.add(
            eventa(i[0],i[1], i[2], i[3],st,et,i[6],i[7]));

      });
    }
    r=await conn.query('select attendee_name from attendee where attendee_id=?',[widget.user]);
    for(var i in r){
      setState(() {
        username=i[0];
      });
    }
    conn.close();
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('attendee_home     ${widget.user}'),
  //       actions: [
  //         TextButton(onPressed: (){
  //
  //           getdata();
  //         }, child: Text('Refresh',style: TextStyle(color: Colors.white),)),
  //       ],
  //     ),
  //
  //     body: GridView.builder(
  //         itemCount: l.length,
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3),
  //
  //         itemBuilder: (context,i){
  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Card(
  //               child: Column(
  //                 children: [
  //                   Text(l[i].event_id.toString()),
  //                   Text(l[i].event_name),
  //                   Text(l[i].domain_name),
  //                   Text(l[i].channel_name),
  //                   Text(l[i].start_time),
  //                   Text(l[i].event_platform),
  //                   Text(l[i].duration),
  //                   RaisedButton(
  //                       child: Text('Register'),
  //                       onPressed: () async{
  //                         var conn =await MySqlConnection.connect(settings);
  //                         var r=await conn.query('insert into registration(event_id,attendee_id,join_status) values(?,?,?)',[l[i].event_id,widget.user,0]);
  //                         conn.close();
  //                         setState(() {
  //                           l.removeAt(i);
  //                         });
  //                       })
  //                 ],
  //               ),
  //             ),
  //           );
  //         }),
  //     drawer: Drawer(
  //       child: Column(
  //         children: [
  //           ListTile(
  //             leading: FaIcon(FontAwesomeIcons.calendarWeek),
  //             title: Text('Calendar'),
  //             onTap: (){
  //               Navigator.push(context,MaterialPageRoute(builder: (context)=>calendar(widget.user)));
  //             },
  //           ),
  //           ListTile(
  //             leading: FaIcon(Icons.event_note),
  //             title: Text('Past_events'),
  //             onTap: (){
  //
  //               Navigator.push(context, MaterialPageRoute(builder: (context)=>registered_event(widget.user)));
  //             }
  //
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.event_available),
  //             title: Text('Current_events'),
  //             onTap: (){
  //               Navigator.push(context, MaterialPageRoute(builder: (context)=>current_events(widget.user)));
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.event_rounded),
  //             title: Text('upcoming_events'),
  //             onTap: (){
  //               Navigator.push(context, MaterialPageRoute(builder: (context)=>upcoming_events(widget.user)));
  //             },
  //
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.person),
  //             title: Text('Profile'),
  //             onTap: (){
  //
  //             },
  //
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.logout),
  //             title: Text('signout'),
  //             onTap: () async{
  //               _auth.signOut();
  //               SharedPreferences prefs=await SharedPreferences.getInstance();
  //               prefs.remove('user');
  //               prefs.remove('pass');
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
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
      drawer: Drawer(
        child: Material(
          color: Color(0xff0E1E37),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // buildMenuItemHeader(
                    // text: 'Nice',
                    // icon: Icons.account_tree_outlined,
                    // onClicked: () {},
                    // ),
                    const SizedBox(height: 50),
                    buildMenuItem(
                        text: 'Calendar',
                        icon: FontAwesomeIcons.calendarWeek,
                        onClicked: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>calendar(widget.user)));

                        }),
                    const SizedBox(height: 16),
                    buildMenuItem(
                        text: 'Past_events',
                        icon: Icons.event_note,
                        onClicked: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>registered_event(widget.user)));

                        }),
                    const SizedBox(height: 16),
                    buildMenuItem(
                        text: 'Current_events',
                        icon: Icons.event_available,
                        onClicked: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>current_events(widget.user)));

                        }),
                    const SizedBox(height: 16),
                    buildMenuItem(
                        text: 'upcoming_events',
                        icon: Icons.event_rounded,
                        onClicked: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>upcoming_events(widget.user)));

                        }),
                    const SizedBox(height: 16),
                    buildMenuItem(
                        text: 'Profile',
                        icon: Icons.person,
                        onClicked: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>upcoming_events(widget.user)));

                        }),
                    const SizedBox(height: 16),
                    buildMenuItem(
                        text: 'sign_out',
                        icon: Icons.logout,
                        onClicked: () async{
                          _auth.signOut();
                          SharedPreferences prefs=await SharedPreferences.getInstance();
                          prefs.remove('user');
                          prefs.remove('pass');
                        }),
                    const SizedBox(height: 80),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 12),
                    buildMenuItem(
                        text: '© Synapse, 2022',
                        icon: Icons.copyright_outlined,
                        onClicked: () => null),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                "Welcome, ${username}!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 60, 20),
              child: Text(
                "Find all the webinars you might be interested to attend, below.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            l1.isNotEmpty?CarouselSlider(
              options: CarouselOptions(
                  height: 150.0,
                  autoPlay: l1.length==1?false:true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 500)),
              items: l1.map((i) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),

                  //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: 700,
                  height: 80,
                  decoration: BoxDecoration(
                    //color: Color.fromRGBO(255, 191, 0,100),
                    border: Border.all(color: Colors.black),
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.centerStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Color.fromRGBO(255, 191, 0, 100),
                          Color.fromRGBO(255, 200, 133, 100),
                        ]),
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
                              child: Text("Webinar on ${i.event_name}",
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
                                Text(i.channel_name,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(128, 0, 0, 100),
                                        fontWeight: FontWeight.bold))
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(1.0),
                              child: Text("${i.start_time.hour.toString()}:${i.start_time.minute.toString()} - ${i.end_time.hour.toString()}:${i.end_time.minute.toString()}, ${i.start_time.day.toString()}th ${d[i.start_time.month]} ${i.start_time.year}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(128, 0, 0, 100),
                                      fontWeight: FontWeight.bold)),
                            ),
                          ]),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("CURRENT EVENT ALERTS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(0, 0, 0, 100),
                                    fontWeight: FontWeight.w900,
                                  )),
                            ]),
                      ),
                      Spacer(),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                                child: Text("JOIN"),
                                onPressed: () async{
                                  var conn =await MySqlConnection.connect(settings);
                                  var r=await conn.query('update registration set join_status=? where event_id=? and attendee_id=?',[1,i.event_id,widget.user]);
                                  conn.close();
                                  if (!await launch(i.event_link)) throw 'Could not launch ${i.event_link}';

                                },
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        decorationColor: Colors.green))),
                          ])
                    ],
                  ),
                );
              }).toList(),
            ):SizedBox(),
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
                        Container(
                          width: 160.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.white70,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>explore(widget.user)));
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'EXPLORE          ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  FontAwesomeIcons.compass,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
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
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    final color = Colors.white;
    // final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: TextStyle(
            color: color,
            fontSize: 14,
          )),
      // hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
