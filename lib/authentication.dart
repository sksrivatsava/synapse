import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:mysql1/mysql1.dart';

import 'package:firedart/firedart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapse/domain_selection.dart';

import 'connection_settings.dart';
import 'loading.dart';


class authentication extends StatefulWidget {

  @override
  _authenticationState createState() => _authenticationState();
}

class _authenticationState extends State<authentication> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  var islog=true;
  var loguser="";
  var logpass="";
  var email="";
  var pass="";
  var username="";
  var typeofuser;
  dynamic attendee_dob;
  var attendee_occupation="employed";
  var attendee_present_qualification="B_Tech";
  var attendee_college="";
  var attendee_branch="CSE";
  var organiser_channel_name="";
  var error1="";
  var error2="";
  var sqlu='insert into user (email,type) values(?,?)';
  var sqla='insert into attendee (attendee_id,attendee_name,attendee_dob,attendee_occupation,attendee_present_qualification,attendee_college,attendee_branch) values(?,?,?,?,?,?,?)';
  var sqlo='insert into organiser (organiser_id,organiser_name,organiser_channel_name) values(?,?,?)';
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentcation'),

      ),
        body:islog?login():register()
    );
  }

  Widget login(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsetsDirectional.all(100.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (ch1) => ch1!.isEmpty ? 'Enter an email' : null,
                    decoration: InputDecoration(
                      labelText: 'email'
                    ),
                    onChanged: (ch1){
                      setState(() {
                        loguser=ch1;
                      });

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                    decoration: InputDecoration(
                      labelText: 'password'
                    ),
                    onChanged: (ch2){
                      setState(() {
                        logpass=ch2;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      child: Text('submit'),
                      onPressed: () async{
                        
                          if (_formKey.currentState!.validate()) {
                            print("--------login----------");
                            print(loguser);
                            print(logpass);
                            SharedPreferences prefs=await SharedPreferences.getInstance();
                              try {
                                await _auth.signIn(loguser, logpass);
                              } on Exception catch (e) {
                                setState(() {
                                  error1=e.toString();
                                });
                              }

                            if(_auth.isSignedIn){
                              print("signed in");
                              print(_auth.getUser());
                              prefs.setString('user',loguser);
                              prefs.setString('pass', logpass);

                            }
                            else{
                              print("nope");
                            
                            }
                          }

                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(error1,style: TextStyle(
                    color: Colors.red
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      child: Text('register'),
                      onPressed: (){
                          setState(() {
                            islog=false;
                          });

                      }),
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
  Widget register(){
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    decoration: InputDecoration(
                        labelText: 'email'
                    ),
                    onChanged: (ch3){
                      setState(() {
                        email=ch3;
                      });

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                    decoration: InputDecoration(
                        labelText: 'password',

                    ),
                    onChanged: (ch5){
                      setState(() {
                        pass=ch5;
                      });

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an username' : null,
                    decoration: InputDecoration(
                        labelText: 'UserName'
                    ),
                    onChanged: (ch6){
                      setState(() {
                        username=ch6;
                      });

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Attendee'),
                    leading: Radio(
                      groupValue: typeofuser,
                      value: 1,
                      onChanged: (ch7){
                        setState(() {
                          typeofuser=1;
                        });

                      },
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Organiser'),
                    leading: Radio(
                      groupValue: typeofuser,
                      value: 2,
                      onChanged: (ch8){
                        setState(() {
                          typeofuser=ch8;
                        });

                      },
                    ),

                  ),
                ),
                typeofuser==1?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                            children:[
                              attendee_dob==null?Text('date_of_birth'):Text(attendee_dob.toString()),
                              Icon(
                          Icons.calendar_today
                        )]),
                        onTap: () async{
                          attendee_dob=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                          setState(() {

                          });
                        },
                      ),
                    ):SizedBox(),
                typeofuser==1?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
              value: attendee_occupation,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                  setState(() {
                    attendee_occupation = newValue!;
                  });
              },
              items: <String>['employed', 'un-employed']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
              }).toList(),
            ),
                ):SizedBox(),
                typeofuser==1?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: attendee_present_qualification,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        attendee_present_qualification = newValue!;
                      });
                    },
                    items: <String>['B_Tech', 'B_sc','M_Tech','M_sc']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ):SizedBox(),
                typeofuser==1?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an college_name' : null,
                    decoration: InputDecoration(
                      labelText: 'colg',

                    ),
                    onChanged: (ch9){
                      setState(() {
                        attendee_college=ch9;
                      });

                    },
                  ),
                ):SizedBox(),
                typeofuser==1?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: attendee_branch,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        attendee_branch = newValue!;
                      });
                    },
                    items: <String>['CSE', 'ECE','EEE','IT']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ):SizedBox(),
                typeofuser==2?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an channel name' : null,
                    decoration: InputDecoration(
                      labelText: 'channel_name',

                    ),
                    onChanged: (ch10){
                      setState(() {
                        organiser_channel_name=ch10;
                      });

                    },
                  ),
                ):SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      child: Text('Submit'),
                      onPressed: () async{




                        if (_formKey.currentState!.validate() && typeofuser!=null) {
                          var conn =await MySqlConnection.connect(settings);
                          try {
                            var tname;



                            print("---------------register----------");
                            print(email);
                            print(pass);
                            print(username);
                            if(typeofuser==1 && attendee_dob!=null){
                              print(attendee_dob);
                              print(attendee_occupation);
                              print(attendee_college);
                              print(attendee_present_qualification);
                              print(attendee_branch);
                              tname='attendee';
                              var r=await conn.query(sqlu,[email,tname]);
                              var dob=attendee_dob.year.toString()+'-'+attendee_dob.month.toString()+'-'+attendee_dob.day.toString();
                              var r1=await conn.query(sqla,[r.insertId,username,dob,attendee_occupation,attendee_present_qualification,attendee_college,attendee_branch]);

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>domain_selection(r.insertId)));



                            }
                            else{
                              print(organiser_channel_name);
                              tname='organiser';
                              var r=await conn.query(sqlu,[email,tname]);
                              var r1=await conn.query(sqlo,[r.insertId,username,organiser_channel_name]);
                            }
                            conn.close();
                            await _auth.signUp(email, pass);
                            SharedPreferences prefs=await SharedPreferences.getInstance();
                            prefs.setString('user',email);
                            prefs.setString('pass', pass);
                          } on Exception catch (e) {
                            // TODO
                            setState(() {
                              error2=e.toString();
                            });
                          }
                        }
                        else{
                          setState(() {
                            if(typeofuser==null) {
                              error2 =error2+" "+ 'select the radio button';
                            }
                            if(attendee_dob==null){
                              error2 =error2+" "+'select dob';
                            }
                          });
                        }



                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(error2,style: TextStyle(
                      color: Colors.red
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      child: Text('login'),
                      onPressed: (){
                      setState(() {
                        islog=true;
                      });
                  }),
                )




              ],
            ),
          ),
        ),
      ),
    );
  }
}
