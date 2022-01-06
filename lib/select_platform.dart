import 'package:flutter/material.dart';
import 'package:synapse/create_event_forms/create_gmeet_event.dart';
import 'package:synapse/create_event_forms/create_zoom_event.dart';
import 'package:url_launcher/url_launcher.dart';

import 'create_event_forms/create_cisco_event.dart';

class selectplatform extends StatefulWidget {
  final user;
  selectplatform(this.user);
  @override
  _selectplatformState createState() => _selectplatformState();
}

class _selectplatformState extends State<selectplatform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Meeting Creation Wizard',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white70,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(250, 10, 250, 10),
        child: Column(
          children: <Widget>[

            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    "Choose any platform to schedule your meeting, from the following options.",
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: <Widget>[
                // TextButton(
                //     child:Text('CREATE ZOOM MEETING'),
                IconButton(
                  icon: Image.asset('assets/images/logo_zoom.png'),
                  iconSize: 100,
                  onPressed: () async{
                    dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>create_zoom_event(widget.user)));
                    if(r=="b"){
                      Navigator.pop(context,"back");
                    }
                  },
                ),
                Spacer(),
                Spacer(),
                IconButton(
                  icon: Image.asset('assets/images/logo_gmeet.png'),
                  iconSize: 100,
                  onPressed: () async{


                    dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>create_gmeet_event(widget.user)));
                    if(r=="b"){
                      Navigator.pop(context,"back");
                    }
                  },
                ),
                Spacer(),
                Spacer(),
                IconButton(
                  icon: Image.asset('assets/images/logo_webex.png'),
                  iconSize: 100,
                  onPressed: () async{
                    dynamic r=await Navigator.push(context, MaterialPageRoute(builder: (context)=>create_cisco_event(widget.user)));
                    if(r=="b"){
                      Navigator.pop(context,"back");
                    }
                  },
                ),
              ]),
            ),

            // Text(zoomLink),

          ],
        ),
      ),
    );
  }

  void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
