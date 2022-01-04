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