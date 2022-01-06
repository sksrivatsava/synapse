import 'package:carousel_slider/carousel_slider.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapse/analytics.dart';
import 'package:synapse/create_meet.dart';
import 'package:synapse/event_form.dart';
import 'package:synapse/organiser_details.dart';
import 'package:synapse/organiser_settings.dart';
import 'package:synapse/select_platform.dart';
import 'package:url_launcher/url_launcher.dart';

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
  DateTime start_time;
  DateTime end_time;
  String duration;
  String event_paltform;
  String event_link;
  event(this.event_name,this.domain_name,this.start_time,this.end_time,this.duration,this.event_paltform,this.event_link);
}
class _organiser_homeState extends State<organiser_home> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  List<event> l=[];
  List<event> fl=[];
  List<event> l1=[];
  var searchFlag = false;
  var username="loading..";
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
    l1=[];
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select * from event where organiser_id=? and start_time>?',[widget.user,DateTime.now().toString()]);


    for(var i in r){
      setState(() {
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[5].year,i[5].month,i[5].day,i[5].hour,i[5].minute,i[5].second);
        l.add(event(i[2], i[3], st, et, i[6].toString(), i[8],i[7]));
      });
      
    }
    fl=List.from(l);

    r=await conn.query('select * from event where organiser_id=? and start_time<=? and end_time>=?',[widget.user,DateTime.now().toString(),DateTime.now().toString()]);
    for(var i in r){
      setState(() {
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[5].year,i[5].month,i[5].day,i[5].hour,i[5].minute,i[5].second);
        l1.add(event(i[2], i[3], st, et, i[6].toString(), i[8],i[7]));
      });

    }
    r=await conn.query('select organiser_name from organiser where organiser_id=?',[widget.user]);
    for(var i in r){
      setState(() {
        username=i[0];
      });
    }
    conn.close();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('organiser_home'),
  //     ),
  //
  //
  //
  //
  //         body: Container(
  //           padding: EdgeInsetsDirectional.all(10),
  //           child: ListView.builder(
  //               itemCount: l.length,
  //               itemBuilder: (context,index){
  //             return Card(
  //               child: Column(
  //                 children: [
  //                   Text(l[index].event_name),
  //                   Text(l[index].domain_name),
  //                   Text(l[index].start_time),
  //                   Text(l[index].end_time),
  //                   Text(l[index].duration),
  //                   Text(l[index].event_paltform),
  //                   Text(l[index].event_link),
  //
  //                 ],
  //               ),
  //             );
  //
  //           }
  //           ),
  //         ),
  //
  //     drawer: Drawer(
  //       child: Column(
  //         children: [
  //
  //           ListTile(
  //               leading: FaIcon(FontAwesomeIcons.chartArea),
  //               title: Text('analytics'),
  //               onTap: (){
  //
  //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>analytics(widget.user)));
  //               }
  //
  //           ),
  //
  //
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
  //
  //
  //     floatingActionButton: FloatingActionButton(
  //       child: Icon(Icons.add),
  //       onPressed: () async{
  //             dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>eventform(widget.user)));
  //         // dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>create_meet()));
  //             if(r=='back'){
  //               getdata();
  //             }
  //       },
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
                        text: 'Analytics',
                        icon: FontAwesomeIcons.chartArea,
                        onClicked: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>analytics(widget.user)));

                        }),
                    const SizedBox(height: 16),
                    buildMenuItem(
                        text: 'Profile',
                        icon: Icons.person,
                        onClicked: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>registered_event(widget.user)));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>organiser_details(widget.user)));
                        }),
                    const SizedBox(height: 16),
                    buildMenuItem(
                        text: 'Settings',
                        icon: Icons.settings,
                        onClicked: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>registered_event(widget.user)));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>organiser_settings(widget.user)));
                        }),
                    const SizedBox(height: 16),
                    buildMenuItem(
                        text: 'Signout',
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
                "Find all your created webinars",
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
                  width: 1000,
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
                                Text("Presented on ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(128, 0, 0, 100),
                                    )),
                                Text(i.event_paltform,
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
                                  // var conn =await MySqlConnection.connect(settings);
                                  // var r=await conn.query('update registration set join_status=? where event_id=? and attendee_id=?',[1,i.event_id,widget.user]);
                                  // conn.close();
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
                                  fl=List.from(l.where((obj)=>obj.event_name.toLowerCase().contains(value.toLowerCase())||obj.domain_name.toLowerCase().contains(value.toLowerCase())||obj.event_paltform.toLowerCase().contains(value.toLowerCase())).toList());
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
                          width: 230.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.white70,
                            onPressed: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>analytics(widget.user)));

                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'SEE ANALYTICS           ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  FontAwesomeIcons.chartArea,
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
                                  Text("Presented on ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(128, 0, 0, 100),
                                      )),
                                  Text("${fl[i].event_paltform}",
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
          floatingActionButton: SizedBox(
            width: 200,
            child: FloatingActionButton(
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),

      child: Text('+ Create Meet'),
      onPressed: () async{
              // dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>eventform(widget.user)));
        dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>selectplatform(widget.user)));
              if(r=='back'){
                getdata();
              }
      },
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
