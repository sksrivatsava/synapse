import 'package:animated_text_kit/animated_text_kit.dart';
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
  // FirebaseAuth _auth=FirebaseAuth.instance;
  // var islog=true;
  // var loguser="";
  // var logpass="";
  // var email="";
  // var pass="";
  // var username="";
  // var typeofuser;
  // dynamic attendee_dob;
  // var attendee_occupation="employed";
  // var attendee_present_qualification="B_Tech";
  // var attendee_college="";
  // var attendee_branch="CSE";
  // var organiser_channel_name="";
  // var error1="";
  // var error2="";
  // var sqlu='insert into user (email,type) values(?,?)';
  // var sqla='insert into attendee (attendee_id,attendee_name,attendee_dob,attendee_occupation,attendee_present_qualification,attendee_college,attendee_branch) values(?,?,?,?,?,?,?)';
  // var sqlo='insert into organiser (organiser_id,organiser_name,organiser_channel_name) values(?,?,?)';
  // final _formKey = GlobalKey<FormState>();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Authentcation'),
  //
  //     ),
  //       body:islog?login():register()
  //   );
  // }
  //
  // Widget login(){
  //   return SingleChildScrollView(
  //     child: Container(
  //       padding: EdgeInsetsDirectional.all(100.0),
  //       child: Center(
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: TextFormField(
  //                   validator: (ch1) => ch1!.isEmpty ? 'Enter an email' : null,
  //                   decoration: InputDecoration(
  //                     labelText: 'email'
  //                   ),
  //                   onChanged: (ch1){
  //                     setState(() {
  //                       loguser=ch1;
  //                     });
  //
  //                   },
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: TextFormField(
  //                   obscureText: true,
  //                   validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
  //                   decoration: InputDecoration(
  //                     labelText: 'password'
  //                   ),
  //                   onChanged: (ch2){
  //                     setState(() {
  //                       logpass=ch2;
  //                     });
  //                   },
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: RaisedButton(
  //                     child: Text('submit'),
  //                     onPressed: () async{
  //
  //                         if (_formKey.currentState!.validate()) {
  //                           print("--------login----------");
  //                           print(loguser);
  //                           print(logpass);
  //                           SharedPreferences prefs=await SharedPreferences.getInstance();
  //                             try {
  //                               await _auth.signIn(loguser, logpass);
  //                             } on Exception catch (e) {
  //                               setState(() {
  //                                 error1=e.toString();
  //                               });
  //                             }
  //
  //                           if(_auth.isSignedIn){
  //                             print("signed in");
  //                             print(_auth.getUser());
  //                             prefs.setString('user',loguser);
  //                             prefs.setString('pass', logpass);
  //
  //                           }
  //                           else{
  //                             print("nope");
  //
  //                           }
  //                         }
  //
  //                 }),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Text(error1,style: TextStyle(
  //                   color: Colors.red
  //                 ),),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: RaisedButton(
  //                     child: Text('register'),
  //                     onPressed: (){
  //                         setState(() {
  //                           islog=false;
  //                         });
  //
  //                     }),
  //               ),
  //
  //             ],
  //           ),
  //         ),
  //       ),
  //
  //     ),
  //   );
  // }
  // Widget register(){
  //   return SingleChildScrollView(
  //     child: Container(
  //       child: Center(
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: TextFormField(
  //                   validator: (val) => val!.isEmpty ? 'Enter an email' : null,
  //                   decoration: InputDecoration(
  //                       labelText: 'email'
  //                   ),
  //                   onChanged: (ch3){
  //                     setState(() {
  //                       email=ch3;
  //                     });
  //
  //                   },
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: TextFormField(
  //                   obscureText: true,
  //                   validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
  //                   decoration: InputDecoration(
  //                       labelText: 'password',
  //
  //                   ),
  //                   onChanged: (ch5){
  //                     setState(() {
  //                       pass=ch5;
  //                     });
  //
  //                   },
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: TextFormField(
  //                   validator: (val) => val!.isEmpty ? 'Enter an username' : null,
  //                   decoration: InputDecoration(
  //                       labelText: 'UserName'
  //                   ),
  //                   onChanged: (ch6){
  //                     setState(() {
  //                       username=ch6;
  //                     });
  //
  //                   },
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: ListTile(
  //                   title: Text('Attendee'),
  //                   leading: Radio(
  //                     groupValue: typeofuser,
  //                     value: 1,
  //                     onChanged: (ch7){
  //                       setState(() {
  //                         typeofuser=1;
  //                       });
  //
  //                     },
  //                   ),
  //
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: ListTile(
  //                   title: Text('Organiser'),
  //                   leading: Radio(
  //                     groupValue: typeofuser,
  //                     value: 2,
  //                     onChanged: (ch8){
  //                       setState(() {
  //                         typeofuser=ch8;
  //                       });
  //
  //                     },
  //                   ),
  //
  //                 ),
  //               ),
  //               typeofuser==1?
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: GestureDetector(
  //                       child: Row(
  //                           children:[
  //                             attendee_dob==null?Text('date_of_birth'):Text(attendee_dob.toString()),
  //                             Icon(
  //                         Icons.calendar_today
  //                       )]),
  //                       onTap: () async{
  //                         attendee_dob=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
  //                         setState(() {
  //
  //                         });
  //                       },
  //                     ),
  //                   ):SizedBox(),
  //               typeofuser==1?Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: DropdownButton<String>(
  //             value: attendee_occupation,
  //             icon: const Icon(Icons.arrow_downward),
  //             elevation: 16,
  //             style: const TextStyle(color: Colors.deepPurple),
  //             underline: Container(
  //                 height: 2,
  //                 color: Colors.deepPurpleAccent,
  //             ),
  //             onChanged: (String? newValue) {
  //                 setState(() {
  //                   attendee_occupation = newValue!;
  //                 });
  //             },
  //             items: <String>['employed', 'un-employed']
  //                   .map<DropdownMenuItem<String>>((String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Text(value),
  //                 );
  //             }).toList(),
  //           ),
  //               ):SizedBox(),
  //               typeofuser==1?
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: DropdownButton<String>(
  //                   value: attendee_present_qualification,
  //                   icon: const Icon(Icons.arrow_downward),
  //                   elevation: 16,
  //                   style: const TextStyle(color: Colors.deepPurple),
  //                   underline: Container(
  //                     height: 2,
  //                     color: Colors.deepPurpleAccent,
  //                   ),
  //                   onChanged: (String? newValue) {
  //                     setState(() {
  //                       attendee_present_qualification = newValue!;
  //                     });
  //                   },
  //                   items: <String>['B_Tech', 'B_sc','M_Tech','M_sc']
  //                       .map<DropdownMenuItem<String>>((String value) {
  //                     return DropdownMenuItem<String>(
  //                       value: value,
  //                       child: Text(value),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ):SizedBox(),
  //               typeofuser==1?
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: TextFormField(
  //                   validator: (val) => val!.isEmpty ? 'Enter an college_name' : null,
  //                   decoration: InputDecoration(
  //                     labelText: 'colg',
  //
  //                   ),
  //                   onChanged: (ch9){
  //                     setState(() {
  //                       attendee_college=ch9;
  //                     });
  //
  //                   },
  //                 ),
  //               ):SizedBox(),
  //               typeofuser==1?Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: DropdownButton<String>(
  //                   value: attendee_branch,
  //                   icon: const Icon(Icons.arrow_downward),
  //                   elevation: 16,
  //                   style: const TextStyle(color: Colors.deepPurple),
  //                   underline: Container(
  //                     height: 2,
  //                     color: Colors.deepPurpleAccent,
  //                   ),
  //                   onChanged: (String? newValue) {
  //                     setState(() {
  //                       attendee_branch = newValue!;
  //                     });
  //                   },
  //                   items: <String>['CSE', 'ECE','EEE','IT']
  //                       .map<DropdownMenuItem<String>>((String value) {
  //                     return DropdownMenuItem<String>(
  //                       value: value,
  //                       child: Text(value),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ):SizedBox(),
  //               typeofuser==2?
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: TextFormField(
  //                   validator: (val) => val!.isEmpty ? 'Enter an channel name' : null,
  //                   decoration: InputDecoration(
  //                     labelText: 'channel_name',
  //
  //                   ),
  //                   onChanged: (ch10){
  //                     setState(() {
  //                       organiser_channel_name=ch10;
  //                     });
  //
  //                   },
  //                 ),
  //               ):SizedBox(),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: RaisedButton(
  //                     child: Text('Submit'),
  //                     onPressed: () async{
  //
  //
  //
  //
  //                       if (_formKey.currentState!.validate() && typeofuser!=null) {
  //                         var conn =await MySqlConnection.connect(settings);
  //                         try {
  //                           var tname;
  //
  //
  //
  //                           print("---------------register----------");
  //                           print(email);
  //                           print(pass);
  //                           print(username);
  //                           if(typeofuser==1 && attendee_dob!=null){
  //                             print(attendee_dob);
  //                             print(attendee_occupation);
  //                             print(attendee_college);
  //                             print(attendee_present_qualification);
  //                             print(attendee_branch);
  //                             tname='attendee';
  //                             var r=await conn.query(sqlu,[email,tname]);
  //                             var dob=attendee_dob.year.toString()+'-'+attendee_dob.month.toString()+'-'+attendee_dob.day.toString();
  //                             var r1=await conn.query(sqla,[r.insertId,username,dob,attendee_occupation,attendee_present_qualification,attendee_college,attendee_branch]);
  //
  //                             Navigator.push(context, MaterialPageRoute(builder: (context)=>domain_selection(r.insertId)));
  //
  //
  //
  //                           }
  //                           else{
  //                             print(organiser_channel_name);
  //                             tname='organiser';
  //                             var r=await conn.query(sqlu,[email,tname]);
  //                             var r1=await conn.query(sqlo,[r.insertId,username,organiser_channel_name]);
  //                           }
  //                           conn.close();
  //                           await _auth.signUp(email, pass);
  //                           SharedPreferences prefs=await SharedPreferences.getInstance();
  //                           prefs.setString('user',email);
  //                           prefs.setString('pass', pass);
  //                         } on Exception catch (e) {
  //                           // TODO
  //                           setState(() {
  //                             error2=e.toString();
  //                           });
  //                         }
  //                       }
  //                       else{
  //                         setState(() {
  //                           if(typeofuser==null) {
  //                             error2 =error2+" "+ 'select the radio button';
  //                           }
  //                           if(attendee_dob==null){
  //                             error2 =error2+" "+'select dob';
  //                           }
  //                         });
  //                       }
  //
  //
  //
  //                 }),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Text(error2,style: TextStyle(
  //                     color: Colors.red
  //                 ),),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: RaisedButton(
  //                     child: Text('login'),
  //                     onPressed: (){
  //                     setState(() {
  //                       islog=true;
  //                     });
  //                 }),
  //               )
  //
  //
  //
  //
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  FirebaseAuth _auth=FirebaseAuth.instance;
  bool islog = true;
  var loguser = "";
  var logpass = "";
  var email = "";
  var pass = "";
  var username = "";
  var typeofuser;
  dynamic attendee_dob;
  var attendee_occupation = "Employed";
  var attendee_present_qualification = "B.Tech";
  var attendee_college = "";
  var attendee_branch = "CSE";
  var organiser_channel_name = "";
  var error1 = "";
  var error2 = "";
  var sqlu = 'insert into user (email,type) values(?,?)';
  var sqla =
      'insert into attendee (attendee_id,attendee_name,attendee_dob,attendee_occupation,attendee_present_qualification,attendee_college,attendee_branch) values(?,?,?,?,?,?,?)';
  var sqlo =
      'insert into organiser (organiser_id,organiser_name,organiser_channel_name) values(?,?,?)';
  final _formKey = GlobalKey<FormState>();
  Color AttendeeButtonColor = Color(0xFF263238);
  Color OrganizerButtonColor = Color(0xFF263238);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
          HomeLeftPane(measure: MediaQuery.of(context).size.height),
          islog ? Login() : Register(),
        ]));
  }

  Widget Login() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(100, 8, 8, 8),
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            )),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 18, 8, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    validator: (ch1) => ch1!.isEmpty
                        ? 'Please enter a valid e-mail address.'
                        : null,
                    decoration: InputDecoration(
                        labelText: 'Enter your e-mail address.'),
                    onChanged: (ch1) {
                      setState(() {
                        loguser = ch1;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 18, 8, 18),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Please ensure your password has more than six characters.'
                        : null,
                    decoration: InputDecoration(labelText: 'Password'),
                    onChanged: (ch2) {
                      setState(() {
                        logpass = ch2;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                        print("--------login----------");
                        print(loguser);
                        print(logpass);
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        try {
                          await _auth.signIn(loguser, logpass);

                        } on Exception catch (e) {
                          setState(() {
                            error1 = e.toString();
                          });
                        }

                        if (_auth.isSignedIn) {
                          print("signed in");
                          print(_auth.getUser());
                          prefs.setString('user', loguser);
                          prefs.setString('pass', logpass);
                        } else {
                          print("nope");
                        }
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  error1,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Register',
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
                    onPressed: () {
                      setState(() {
                        islog = false;
                      });
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Register() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(100, 8, 8, 8),
              child: Text(
                "Register",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(125, 8, 8, 8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                        validator: (val) => val!.isEmpty
                            ? 'Kindly enter a valid, non null email address.'
                            : null,
                        decoration: InputDecoration(labelText: 'eMail Address'),
                        onChanged: (ch3) {
                          setState(() {
                            email = ch3;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Kindly enter a password that is atleast 7 characters in length.'
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        onChanged: (ch5) {
                          setState(() {
                            pass = ch5;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding( 
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                        validator: (val) => val!.isEmpty
                            ? 'Kindly pick a username. Do not leave this field blank.'
                            : null,
                        decoration: InputDecoration(labelText: 'Username'),
                        onChanged: (ch6) {
                          setState(() {
                            username = ch6;
                          });
                        },
                      ),
                    ),
                  ),
                  Row( 
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: RaisedButton(
                            color: AttendeeButtonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0)),
                            onPressed: () {
                              setState(() {
                                typeofuser = 1;
                                OrganizerButtonColor = Color(0xFF616161);
                                AttendeeButtonColor = Color(0XFFD6D6D6);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text( 
                                    'Attendee     ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: RaisedButton(
                            color: OrganizerButtonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0)),
                            onPressed: () {
                              setState(() {
                                typeofuser = 2;
                                AttendeeButtonColor = Color(0xFF616161);
                                OrganizerButtonColor = Color(0XFFD6D6D6);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Organiser     ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Icon(
                                  Icons.screen_share_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  typeofuser == 1
                      ? Column(children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: GestureDetector(
                          child: Row(children: [
                            attendee_dob == null
                                ? Text('Date of Birth')
                                : Text(attendee_dob.year.toString() +
                                '-' +
                                attendee_dob.month.toString() +
                                '-' +
                                attendee_dob.day.toString()),
                            Icon(Icons.calendar_today)
                          ]),
                          onTap: () async {
                            attendee_dob = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            setState(() {

                            });

                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(30.0),
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
                          items: <String>[
                            'Employed',
                            'Unemployed',
                            'Self-Employed'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
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
                          items: <String>[
                            'B.Tech',
                            'B.Sc',
                            'M.Tech',
                            'M.Sc'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Please enter the name of your college to proceed.'
                                : null,
                            decoration: InputDecoration(
                              labelText: 'College Name',
                            ),
                            onChanged: (ch9) {
                              setState(() {
                                attendee_college = ch9;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
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
                          items: <String>[
                            'CSE',
                            'IT',
                            'ECE',
                            'EEE',
                            'ECM',
                            'MECH',
                            'CIV',
                            'Maths',
                            'Physics',
                            'Chemistry',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                    ])
                  ])
                      : SizedBox(),
                  typeofuser == 2
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                        validator: (val) =>
                        val!.isEmpty ? 'Enter an channel name' : null,
                        decoration: InputDecoration(
                          labelText: 'Channel Name',
                        ),
                        onChanged: (ch10) {
                          setState(() {
                            organiser_channel_name = ch10;
                          });
                        },
                      ),
                    ),
                  )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
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
                            if (typeofuser != null) {

                              try {
                                var tname;

                                print("---------------register----------");
                                print(email);
                                print(pass);
                                print(username);
                                if (typeofuser == 1) {
                                  if (attendee_dob != null) {
                                    await _auth.signUp(email, pass);
                                    _auth.signOut();
                                    print(attendee_dob);
                                    print(attendee_occupation);
                                    print(attendee_college);
                                    print(attendee_present_qualification);
                                    print(attendee_branch);
                                    tname = 'attendee';
                                    var conn = await MySqlConnection.connect(settings);
                                    var r = await conn.query(
                                        sqlu, [email, tname]);
                                    var dob = attendee_dob.year.toString() +
                                        '-' +
                                        attendee_dob.month.toString() +
                                        '-' +
                                        attendee_dob.day.toString();
                                    var r1 = await conn.query(sqla, [
                                      r.insertId,
                                      username,
                                      dob,
                                      attendee_occupation,
                                      attendee_present_qualification,
                                      attendee_college,
                                      attendee_branch
                                    ]);
                                    conn.close();
                                    _auth.signIn(email, pass);
                                    SharedPreferences prefs = await SharedPreferences
                                        .getInstance();
                                    prefs.setString('user', email);
                                    prefs.setString('pass', pass);


                                  }
                                  else {
                                    print("calender");
                                    setState(() {
                                      error2 =
                                      "Kindly select your date of birth from the calendar icon.";
                                    });
                                  }
                                } else {
                                  print(organiser_channel_name);
                                  tname = 'organiser';
                                  var conn = await MySqlConnection.connect(settings);
                                  await _auth.signUp(email, pass);
                                  _auth.signOut();
                                  var r = await conn.query(sqlu, [email, tname]);
                                  var r1 = await conn.query(sqlo, [
                                    r.insertId,
                                    username,
                                    organiser_channel_name
                                  ]);
                                  conn.close();
                                  _auth.signIn(email, pass);
                                  SharedPreferences prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.setString('user', email);
                                  prefs.setString('pass', pass);
                                }



                              } on Exception catch (e) {
                                // TODO
                                print("catch");

                                  setState(() {
                                    error2 = e.toString();
                                  });
                                  print(error2);

                              }
                            }
                            else {
                              print("button");
                              setState(() {
                                error2 =
                                "Please choose a type from the two buttons above.";
                              });
                            }
                          }
                          // } else {
                          //   setState(() {
                          //     if (typeofuser == null) {
                          //       error2 =
                          //       'Please choose a type from the two buttons above.';
                          //     } else if (attendee_dob == null) {
                          //       error2 =
                          //       '\nKindly select your date of birth from the calendar icon.';
                          //     }
                          //   });
                          // }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      error2,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Login',
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
                        onPressed: () {
                          setState(() {
                            islog = true;
                          });
                        }),
                  )
                ],
              ),
            ),
          ),
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
                    'Synapse',
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
                "A one stop abode for Attendees, Organisers, and a lot of knowledge shared :)",
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
