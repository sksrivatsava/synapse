import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:synapse/registered_events.dart';

class attendee_home extends StatefulWidget {
  final user;
  final conn;
  attendee_home(this.user,this.conn);
  @override
  _attendee_homeState createState() => _attendee_homeState();
}
class eventa{
  int event_id;
  String event_name;
  String domain_name;
  String channel_name;
  String start_time;
  String duration;
  String event_platform;
  eventa(this.event_id,this.event_name,this.domain_name,this.channel_name,this.start_time,this.duration,this.event_platform);
}
class _attendee_homeState extends State<attendee_home> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  List<eventa> l=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();

  }
  void getdata() async{
    l=[];
    var r=await widget.conn.query('select * from event e inner join organiser o on e.organiser_id=o.organiser_id where e.domain_name in (select domain_name from domain where attendee_id=?) and e.event_id not in (select event_id from registration where attendee_id=?) and e.end_time>?',[widget.user,widget.user,DateTime.now().toString()]);
    for(var i in r) {
      setState(() {
        l.add(
            eventa(i[0],i[2], i[3], i[10], i[4].toString(), i[6].toString(), i[8]));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('attendee_home'),
      ),

      body: CollapsibleSidebar(
        title: 'Synapse',
        isCollapsed: false,
        avatarImg: NetworkImage('https://www.pngplay.com/wp-content/uploads/5/Webinar-Logo-Wifi-PNG.png'),
        items: [
          CollapsibleItem(text: 'Calendar', icon: Icons.calendar_today, onPressed: (){}),
          CollapsibleItem(text: 'Registered_events', icon: Icons.event_note, onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>registered_event(widget.user, widget.conn)));
          }),
          CollapsibleItem(text: 'current_events', icon: Icons.event_available, onPressed: (){}),
          CollapsibleItem(text: 'upcoming_events', icon: Icons.event_rounded, onPressed: (){}),
          CollapsibleItem(text: 'Proifle', icon: Icons.person, onPressed: (){},isSelected: true),
          CollapsibleItem(text: 'Signout', icon: Icons.logout, onPressed: (){

            _auth.signOut();
          })


        ],
        body:GridView.builder(
          itemCount: l.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3),

            itemBuilder: (context,i){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
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
                            child: Text('Register'),
                            onPressed: () async{
                                    var r=await widget.conn.query('insert into registration(event_id,attendee_id,join_status) values(?,?,?)',[l[i].event_id,widget.user,0]);
                                    setState(() {
                                      l.removeAt(i);
                                    });
                        })
                      ],
                    ),
                  ),
                );
            })
      )
    );
  }
}
