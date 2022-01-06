import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import '../connection_settings.dart';

class organiser_update_jwt_token extends StatefulWidget {
  final user;
  organiser_update_jwt_token(this.user);
  @override
  _organiser_update_jwt_tokenState createState() => _organiser_update_jwt_tokenState();
}

class _organiser_update_jwt_tokenState extends State<organiser_update_jwt_token> {
  final _formKey = GlobalKey<FormState>();
  var JWT_TOKEN="";
  TextEditingController _controller=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void getdata() async{
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select JWT_TOKEN from organiser where organiser_id=?',[widget.user] );
    conn.close();
    for(var i in r){
      setState(() {
        JWT_TOKEN=i[0];
        if(JWT_TOKEN==null){
          JWT_TOKEN="";
        }
      });
    }
    setState(() {
      _controller.text=JWT_TOKEN;
    });
  }
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
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Padding(
                padding: const EdgeInsets.fromLTRB(100, 18, 8, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    controller: _controller,
                    maxLines: 4,
                    validator: (ch1) => ch1!.isEmpty
                        ? 'update JWT_TOKEN'
                        : null,
                    decoration: InputDecoration(
                        labelText: 'JWT_TOKEN'),
                    onChanged: (ch1) {
                      setState(() {
                        JWT_TOKEN= ch1;
                      });
                    },
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var conn =await MySqlConnection.connect(settings);
                          var r=await conn.query('update organiser set JWT_TOKEN=? where organiser_id=?',[JWT_TOKEN,widget.user] );
                          conn.close();
                          Navigator.pop(context);
                        }
                      }),
                ),

              ],
            ),
          )
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
                    'update JWT_TOKEN',
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

        ],
      ),
    );
  }
}