import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'connection_settings.dart';

class organiser_details extends StatefulWidget {
  final user;
  organiser_details(this.user);
  @override
  _organiser_detailsState createState() => _organiser_detailsState();
}

class _organiser_detailsState extends State<organiser_details> {
  var organizerName = "";
  var channelName = "";
  var numberOfEvents = 0;
  var domains = [

  ];
  var bio =
      "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    var conn = await MySqlConnection.connect(settings);
    var r = await conn.query(
        'select organiser_name,organiser_channel_name,organiser_bio from organiser where organiser_id=?',
        [widget.user]);
    for (var i in r) {
      setState(() {
        organizerName = i[0];
        channelName = i[1];
        bio = i[2];
      });
    }
    r = await conn.query(
        'select count(*) from event GROUP by organiser_id HAVING organiser_id=?',
        [widget.user]);
    for (var i in r) {
      setState(() {
        numberOfEvents = i[0];
      });
    }
    r = await conn.query(
        'SELECT DISTINCT(domain_name) from event WHERE organiser_id=?',
        [widget.user]);
    for (var i in r) {
      setState(() {
        domains.add(i[0]);
      });
    }
    conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: Color(0xff0E1E37),

          bottomOpacity: 0,
        ),
        body: Row(children: [
      HomeLeftPane(
        measure: MediaQuery.of(context).size.height,
        organizerName: organizerName,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 30),
                ClipRRect(
                  child: Image.network(
                    'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
                    //'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                    width: 100,
                    height: 100,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                // SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      child: Text(
                        channelName,
                        // 'ashish chanchlani vines vines',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, right: 20.0, left: 0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Webinars Conducted",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      SizedBox(height: 10),
                      Text(numberOfEvents.toString(),
                          // '250000000',
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                    ],
                  ),
                ),
                // SizedBox(width: 30),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Domains",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      SizedBox(height: 10),
                      domains.isNotEmpty
                          ? Text(domains.join('\n'),
                              //   '2550000001',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0))
                          : Text('No events created',
                              //   '2550000001',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                    ],
                  ),
                ),
                // SizedBox(width: 30),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text("About:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 50),
                    child: bio!=null?Text(bio,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)):Text('No bio',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]));
  }
}

// class OrganizerDetailsRightPane extends StatelessWidget {
//   double measure;
//   String organizerName;
//   String channelName;
//   int numberOfEvents;
//   List<dynamic> domains;
//   String bio;
//
//   OrganizerDetailsRightPane(
//       {required this.measure,
//       required this.organizerName,
//       required this.channelName,
//       required this.numberOfEvents,
//       required this.domains,
//       this.bio = ""});
//
//   Widget build(BuildContext c) {
//     return Container(
//       width: measure * 0.4,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               SizedBox(width: 30),
//               ClipRRect(
//                 child: Image.network(
//                   'https://image.shutterstock.com/image-vector/gray-avatar-icon-design-photo-260nw-1274338147.jpg',
//                   //'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
//                   width: 100,
//                   height: 100,
//                 ),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               // SizedBox(width: 20),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Padding(
//                     child: Text(
//                       channelName,
//                       // 'ashish chanchlani vines vines',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 32.0,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     padding: EdgeInsets.only(
//                         top: 20.0, bottom: 20.0, right: 20.0, left: 0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 40),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   children: <Widget>[
//                     Text("Webinars Conducted",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0)),
//                     SizedBox(height: 10),
//                     Text(numberOfEvents.toString(),
//                         // '250000000',
//                         style: TextStyle(color: Colors.black, fontSize: 20.0)),
//                   ],
//                 ),
//               ),
//               // SizedBox(width: 30),
//               Expanded(
//                 child: Column(
//                   children: <Widget>[
//                     Text("Domains",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0)),
//                     SizedBox(height: 10),
//                     domains.isNotEmpty
//                         ? Text(domains.join('\n'),
//                             //   '2550000001',
//                             style:
//                                 TextStyle(color: Colors.black, fontSize: 20.0))
//                         : Text('No events created',
//                             //   '2550000001',
//                             style:
//                                 TextStyle(color: Colors.black, fontSize: 20.0)),
//                   ],
//                 ),
//               ),
//               // SizedBox(width: 30),
//             ],
//           ),
//           SizedBox(height: 40),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 50),
//                   child: Text("About:",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16.0)),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 50),
//                   child: Text(bio,
//                       textAlign: TextAlign.justify,
//                       style: TextStyle(color: Colors.black, fontSize: 16.0)),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomeLeftPane extends StatelessWidget {
  double measure;
  String organizerName;
  HomeLeftPane({required this.measure, required this.organizerName});

  Widget build(BuildContext c) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: measure * 0.6,
      height: measure,
      color: Color(0xff0E1E37),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(40, 100, 10, 10),
              child: Text(
                "About ${organizerName}",
                style: const TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 140, 40, 10),
            child: Text("A gist of all details known about the organizer.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w300)),
          ),
        ],
      ),
    );
  }
}
