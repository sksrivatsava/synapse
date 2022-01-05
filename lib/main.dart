// @dart=2.9
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'package:firedart/firedart.dart';
import 'package:synapse/loading.dart';

import 'auth_tool.dart';
import 'authentication.dart';
import 'connection_settings.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{

  FirebaseAuth.initialize('AIzaSyA3LxarRw6wCEAYK0EVrwMviZ_O4srwMzw', VolatileStore());
  runApp(MaterialApp(

    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  var log=false;
  var conn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    islog();
    // getconnect();

  }
  // void getconnect() async{
  //   var conn1 =await MySqlConnection.connect(settings);
  //
  //   setState(() {
  //     conn=conn1;
  //   });
  //
  // }
  void islog() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    if(prefs.getString('user')!=null && prefs.getString('pass')!=null){
      _auth.signIn(prefs.getString('user'), prefs.getString('pass'));
    }

    print("nice");
    _auth.signInState.listen((event) {
      print("nice2");
      print(event);
      setState(() {
        log=event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {



    if (log) {
      return home();
    }
    else {
      return authentication();
    }


  }
}


// import 'package:flutter/material.dart';
//
// void main() => runApp(MaterialApp(home: MyApp()));
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff0E1E37),
//         brightness: Brightness.light,
//         toolbarHeight: 150,
//         elevation: 0,
//         title: Text(
//           'Ad Application Portal',
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.black87, fontSize: 22),
//         ),
//         leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black87,
//             ),
//             onPressed: () {
//               // Navigator.pop(context);
//             }),
//       ),
//       drawer: Drawer(
//         child: Material(
//           color: Color(0xff0E1E37),
//           child: ListView(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 24),
//                     // buildMenuItemHeader(
//                     // text: 'Nice',
//                     // icon: Icons.account_tree_outlined,
//                     // onClicked: () {},
//                     // ),
//                     const SizedBox(height: 50),
//                     buildMenuItem(
//                         text: 'Applied Advertisers',
//                         icon: Icons.sensors,
//                         onClicked: () => null),
//                     const SizedBox(height: 16),
//                     buildMenuItem(
//                         text: 'Confirmed Advertisers',
//                         icon: Icons.check,
//                         onClicked: () => null),
//                     const SizedBox(height: 16),
//                     buildMenuItem(
//                         text: 'Rejected Advertisers',
//                         icon: Icons.sensors_off,
//                         onClicked: () => null),
//                     const SizedBox(height: 16),
//                     buildMenuItem(
//                         text: 'Submitted Advertisers',
//                         icon: Icons.checklist_outlined,
//                         onClicked: () => null),
//                     const SizedBox(height: 80),
//                     Divider(color: Colors.white70),
//                     const SizedBox(height: 12),
//                     buildMenuItem(
//                         text: '© Adcons, 2021',
//                         icon: Icons.copyright_outlined,
//                         onClicked: () => null),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 20, 60, 10),
//             child: Text(
//               "Welcome, Krishna Srivatsava!",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 45,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 0, 60, 20),
//             child: Text(
//               "Find all the webinars you might be interested to attend, below.",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 25,
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               shrinkWrap: true,
//               itemCount: 15,
//               padding: EdgeInsets.all(40),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   childAspectRatio: 50.0 / 10.0,
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 30,
//                   mainAxisSpacing: 20),
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//
//                   //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   width: 200,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(7.5),
//                     boxShadow: [
//                       BoxShadow(
//                         offset: Offset(0, 20),
//                         blurRadius: 53,
//                         color: Color(0xFFD3D3D3).withOpacity(.84),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.all(1.0),
//                               child: Text("Webinar on Synapse",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       fontSize: 21,
//                                       color: Color.fromRGBO(128, 0, 0, 100),
//                                       fontWeight: FontWeight.bold)),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(1.0),
//                               child: Row(children: [
//                                 Text("Presented by ",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Color.fromRGBO(128, 0, 0, 100),
//                                     )),
//                                 Text("S Krishna Srivatsava",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: Color.fromRGBO(128, 0, 0, 100),
//                                         fontWeight: FontWeight.bold))
//                               ]),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(1.0),
//                               child: Text("13:00 - 15:00, 12th January 2022",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Color.fromRGBO(128, 0, 0, 100),
//                                       fontWeight: FontWeight.bold)),
//                             ),
//                           ]),
//                       Spacer(),
//                       Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             TextButton(
//                                 child: Text('JOIN'),
//                                 onPressed: () {},
//                                 style: TextButton.styleFrom(
//                                     textStyle: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         decorationColor: Colors.green))),
//                             TextButton(
//                                 child: Text('REGISTER'),
//                                 onPressed: () {},
//                                 style: TextButton.styleFrom(
//                                     textStyle: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         decorationColor: Colors.red)))
//                           ])
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//
//       // Container(
//       //   height: MediaQuery.of(context).size.height * 0.20,
//       // ),
//       // Padding(
//       //   padding: EdgeInsets.fromLTRB(30, 20, 20, 10),
//       //   child: Text(
//       //     'Events you might be interested in:',
//       //     style: TextStyle(color: Colors.black, fontSize: 25),
//       //   ),
//       // ),
//       // Center(
//       //   child: Container(
//       //     width: MediaQuery.of(context).size.width * 0.70,
//       //     padding: EdgeInsets.fromLTRB(400, 15, 15, 15),
//       //     height: MediaQuery.of(context).size.height * 0.70,
//       //     child: SingleChildScrollView(
//       //         scrollDirection: Axis.vertical,
//       //         child: Column(children: <Widget>[
//       //           Container(
//       //               padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
//       //               height: 250,
//       //               width: MediaQuery.of(context).size.width * 0.70,
//       //               child: Card(
//       //                 color: Colors.grey[300],
//       //                 child: Row(children: [
//       //                   Container(
//       //                       width: 600,
//       //                       child: Column(children: [
//       //                         Container(
//       //                             padding: EdgeInsets.fromLTRB(
//       //                                 20, 20, 20, 20),
//       //                             child: const Text(
//       //                               "React Webinar",
//       //                               style: TextStyle(
//       //                                 fontSize: 20,
//       //                               ),
//       //                             )),
//       //                         Container(child: Text('presented by SK')),
//       //                         Row(children: [
//       //                           Container(
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: const Text(
//       //                                 'Timings:10:00 -12:00',
//       //                               )),
//       //                           Container(
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: Text('Date:31-12-2021')),
//       //                         ])
//       //                       ])),
//       //                   Container(
//       //                       padding:
//       //                           EdgeInsets.fromLTRB(20, 20, 20, 20),
//       //                       child: Column(
//       //                         children: [
//       //                           Container(
//       //                               width: 100,
//       //                               height: 60,
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: SizedBox(
//       //                                   width: 70,
//       //                                   height: 30,
//       //                                   child: ElevatedButton(
//       //                                       onPressed: () {},
//       //                                       child: Text('Register')))),
//       //                           Container(
//       //                             padding: EdgeInsets.fromLTRB(
//       //                                 20, 20, 20, 20),
//       //                             width: 100,
//       //                             height: 60,
//       //                             child: SizedBox(
//       //                                 width: 50,
//       //                                 height: 30,
//       //                                 child: ElevatedButton(
//       //                                     onPressed: () {},
//       //                                     child: Text('Join now'))),
//       //                           )
//       //                         ],
//       //                       )),
//       //                 ]),
//       //               )),
//       //           Container(
//       //               padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
//       //               width: MediaQuery.of(context).size.width * 0.70,
//       //               height: 250,
//       //               child: Card(
//       //                 color: Colors.grey[300],
//       //                 child: Row(children: [
//       //                   Container(
//       //                       width: 600,
//       //                       child: Column(children: [
//       //                         Container(
//       //                             padding: EdgeInsets.fromLTRB(
//       //                                 20, 20, 20, 20),
//       //                             child: Text(
//       //                               "React Webinar",
//       //                               style: TextStyle(
//       //                                 fontSize: 20,
//       //                               ),
//       //                             )),
//       //                         Container(child: Text('presented by SK')),
//       //                         Row(children: [
//       //                           Container(
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: Text(
//       //                                 'Timings:10:00 -12:00',
//       //                               )),
//       //                           Container(
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: Text('Date:31-12-2021')),
//       //                         ])
//       //                       ])),
//       //                   Container(),
//       //                 ]),
//       //               )),
//       //           Container(
//       //               padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
//       //               width: MediaQuery.of(context).size.width * 0.70,
//       //               height: 250,
//       //               child: Card(
//       //                 color: Colors.grey[300],
//       //                 child: Row(children: [
//       //                   Container(
//       //                       width: 600,
//       //                       child: Column(children: [
//       //                         Container(
//       //                             padding: EdgeInsets.fromLTRB(
//       //                                 20, 20, 20, 20),
//       //                             child: const Text(
//       //                               "React Webinar",
//       //                               style: TextStyle(
//       //                                 fontSize: 20,
//       //                               ),
//       //                             )),
//       //                         Container(child: Text('presented by SK')),
//       //                         Row(children: [
//       //                           Container(
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: const Text(
//       //                                 'Timings:10:00 -12:00',
//       //                               )),
//       //                           Container(
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: Text('Date:31-12-2021')),
//       //                         ])
//       //                       ])),
//       //                   Container(),
//       //                 ]),
//       //               )),
//       //           Container(
//       //               padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
//       //               width: MediaQuery.of(context).size.width * 0.70,
//       //               height: 250,
//       //               child: Card(
//       //                 color: Colors.grey[300],
//       //                 child: Row(children: [
//       //                   Container(
//       //                       width: 600,
//       //                       child: Column(children: [
//       //                         Container(
//       //                             padding: const EdgeInsets.fromLTRB(
//       //                                 20, 20, 20, 20),
//       //                             child: const Text(
//       //                               "React Webinar",
//       //                               style: TextStyle(
//       //                                 fontSize: 20,
//       //                               ),
//       //                             )),
//       //                         Container(child: Text('presented by SK')),
//       //                         Row(children: [
//       //                           Container(
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: const Text(
//       //                                 'Timings:10:00 -12:00',
//       //                               )),
//       //                           Container(
//       //                               padding: EdgeInsets.fromLTRB(
//       //                                   20, 20, 20, 20),
//       //                               child: Text('Date:31-12-2021')),
//       //                         ])
//       //                       ])),
//       //                   Container(),
//       //                 ]),
//       //               ))
//       //         ])),
//       //   ),
//       // ),
//       //     ],
//       //   )
//       // ])
//     );
//   }
//
//   Widget buildMenuItem({
//     required String text,
//     required IconData icon,
//     required VoidCallback onClicked,
//   }) {
//     final color = Colors.white;
//     // final hoverColor = Colors.white70;
//
//     return ListTile(
//       leading: Icon(icon, color: color),
//       title: Text(text,
//           style: TextStyle(
//             color: color,
//             fontSize: 14,
//           )),
//       // hoverColor: hoverColor,
//       onTap: onClicked,
//     );
//   }
// }
//
// class HomeNavBar extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.bottomLeft,
//       width: MediaQuery.of(context).size.height * 0.45,
//       height: MediaQuery.of(context).size.height,
//       color: Color(0xff0E1E37),
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Color(0xff0E1E37),
//             ),
//             child: Text(''),
//           ),
//           ListTile(
//             title: const Text(
//               'Home',
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white),
//             ),
//             onTap: () {},
//           ),
//           ListTile(
//             title: const Text(
//               'Calender',
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white),
//             ),
//             onTap: () {},
//           ),
//           ListTile(
//             title: const Text(
//               'Registered Webinars',
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white),
//             ),
//             onTap: () {},
//           ),
//           ListTile(
//             title: const Text(
//               'Upcoming Webinars',
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white),
//             ),
//             onTap: () {},
//           ),
//           ListTile(
//             title: const Text(
//               'Profile',
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white),
//             ),
//             onTap: () {},
//           ),
//           ListTile(
//             title: const Text(
//               'Settings',
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white),
//             ),
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
//
