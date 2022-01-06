import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:synapse/organiser_settings_page/oraganiser_edit_bio.dart';
import 'package:synapse/organiser_settings_page/organiser_change_channel_name.dart';
import 'package:synapse/organiser_settings_page/organiser_change_password.dart';
import 'package:synapse/organiser_settings_page/organiser_change_username.dart';
import 'package:synapse/organiser_settings_page/organiser_update_jwt_token.dart';

class organiser_settings extends StatefulWidget {
  final user;
  organiser_settings(this.user);
  @override
  _organiser_settingsState createState() => _organiser_settingsState();
}

class _organiser_settingsState extends State<organiser_settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xff0E1E37),

        bottomOpacity: 0,
      ),
      body: Row(
        children: [
          HomeLeftPane(measure: MediaQuery.of(context).size.height),
          Expanded(
              child: GridView.count(
            shrinkWrap: true,

    childAspectRatio: 50.0 / 10.0,
    crossAxisCount: 2,
    crossAxisSpacing: 30,
    mainAxisSpacing: 20,
            padding: EdgeInsets.all(40),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     childAspectRatio: 50.0 / 10.0,
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 30,
            //     mainAxisSpacing: 20),
            children: [
              Container(
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
                            child: Text("Change Username",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Color.fromRGBO(128, 0, 0, 100),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ]),
                    Spacer(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          TextButton(
                              child: Text('CHANGE'),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>organiser_change_username(widget.user)));
                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decorationColor: Colors.red)))
                        ])
                  ],
                ),
              ),
              Container(
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
                            child: Text("Change Password",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Color.fromRGBO(128, 0, 0, 100),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ]),
                    Spacer(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          TextButton(
                              child: Text('CHANGE'),
                              onPressed: ()  {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>organiser_change_password(widget.user)));

                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decorationColor: Colors.red)))
                        ])
                  ],
                ),
              ),
              Container(
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
                            child: Text("Edit Bio",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Color.fromRGBO(128, 0, 0, 100),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ]),
                    Spacer(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          TextButton(
                              child: Text('CHANGE'),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>organiser_edit_bio(widget.user)));


                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decorationColor: Colors.red)))
                        ])
                  ],
                ),
              ),
              Container(
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
                            child: Text("Change Channel Name",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Color.fromRGBO(128, 0, 0, 100),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ]),
                    Spacer(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          TextButton(
                              child: Text('CHANGE'),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>organiser_change_channel_name(widget.user)));
                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decorationColor: Colors.red)))
                        ])
                  ],
                ),
              ),
              Container(
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
                            child: Text("Update JWT TOKEN",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Color.fromRGBO(128, 0, 0, 100),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ]),
                    Spacer(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          TextButton(
                              child: Text('CHANGE'),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>organiser_update_jwt_token(widget.user)));

                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decorationColor: Colors.red)))
                        ])
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

class HomeLeftPane extends StatelessWidget {
  double measure;
  HomeLeftPane({required this.measure});

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
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Settings',
                    textStyle: const TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                    speed: const Duration(milliseconds: 80),
                  ),
                ],
                totalRepeatCount: 100,
                pause: const Duration(milliseconds: 3000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 140, 40, 10),
            child: Text(
                "Check out things you can change and customize about your profile, here.",
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
