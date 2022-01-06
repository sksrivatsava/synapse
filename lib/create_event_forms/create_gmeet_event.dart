import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../connection_settings.dart';

class create_gmeet_event extends StatefulWidget {
  final user;
  create_gmeet_event(this.user);
  @override
  _create_gmeet_eventState createState() => _create_gmeet_eventState();
}

class _create_gmeet_eventState extends State<create_gmeet_event> {
  String url = '';

  var Data;
  var domainList = [
    "Machine Learning",
    "Internet of Things",
    "Big Data Analytics",
    "Data Mining",
    "Agile Software Development",
    "VLSI",
    "Embedded Systems",
    "Indian Economy",
    "Advanced Entrepreneurship",
    "Electronic Circuit Design",
    "Operations Research",
    "Banking Operations",
    "Indian Culture and Geography",
    "Innovation and Design Thinking"
  ];

  var currentSelectedValue = "Machine Learning";
  final deviceTypes = ["Mac", "Windows", "Mobile"];
  //var currentSelectedValue = "Machine Learning";
  String topic = '';
  String start_time = '';
  dynamic end_time;
  String duration = '';
  // String JWT_TOKEN =
  //     "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOm51bGwsImlzcyI6IkpUOEw1eklGU2tLNk1Kdml4cVpXTXciLCJleHAiOjE2NzE4ODY2MjAsImlhdCI6MTY0MDM1MDA5OX0.twIT019QmQeSYi6X4pp6zNlIcjnOCEAbIbBIsGNmsxs";
  String JWT_TOKEN="";
  dynamic selectedDateTime;

  String LABELTEXT_topic = 'Enter the subject of the meeting to be scheduled.';
  String LABELTEXT_start_time = 'Select the start time of the meeting.';
  String LABELTEXT_duration = 'Enter the duration of the meeting in minutes.';
  String LABELTEXT_link = 'enter the meeting link';

  String ERRORTEXT_topic =
      "Please DO NOT leave this field blank. Enter the subject of the meeting.";
  String ERRORTEXT_start_time =
      "Please select a valid time and date from the calendar.";
  String ERRORTEXT_duration =
      "Please DO NOT leave this field blank. Enter a valid duration in minutes.";
  String ERRORTEXT_dropdown = "Select a domain.";
  String ERRORTEXT_link =
      "Please DO NOT leave this field blank. Enter a valid link..";

  TextEditingController CONTROLLER_topic = TextEditingController();
  TextEditingController CONTROLLER_start_time = TextEditingController();
  TextEditingController CONTROLLER_duration = TextEditingController();
  TextEditingController CONTROLLER_link = TextEditingController();
  var link="";
  var STATUS_topic = "";
  var STATUS_start_time = "";
  var STATUS_duration = "";
  var STATUS_link = "";
  var STATUS_dropdown ="true";
  dynamic sql="insert into event(organiser_id,event_name,domain_name,start_time,end_time,duration,event_link,evant_platform) values (?,?,?,?,?,?,?,?)";

  var platform = "";
  String zoomStatus = '';
  String zoomLink = '';
  String zoomPassword = '';
  String zoomMessage = '';
  String zoomText ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Meeting Creation Wizard',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white70,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(250, 10, 250, 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: CONTROLLER_topic,
                  onChanged: (value) {
                    topic = value.toString();
                  },
                  decoration: InputDecoration(
                    labelText: LABELTEXT_topic,
                    hintText: "Type something.",
                    hintStyle: TextStyle(height: 2),
                    errorText: STATUS_topic == "false" ? ERRORTEXT_topic : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: CONTROLLER_start_time,
                  readOnly: true,
                  enableInteractiveSelection: true,
                  onChanged: (value) {
                    start_time = value.toString();
                  },
                  decoration: InputDecoration(
                      labelText: LABELTEXT_start_time,
                      hintText: "Click on the Calendar icon.",
                      hintStyle: TextStyle(height: 2),
                      errorText: STATUS_start_time == "false"
                          ? ERRORTEXT_start_time
                          : null,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2020, 1, 1),
                                maxTime: DateTime(2030, 1, 1),
                                onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  setState(() {
                                    selectedDateTime = date;
                                    start_time = selectedDateTime.toString();
                                  });
                                }, currentTime: DateTime.now(), locale: LocaleType.en)
                                .then((selectedDateTime) {
                              CONTROLLER_start_time.text =
                                  selectedDateTime.toString();
                            });
                          },
                          child: Icon(Icons.calendar_today))),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return Container(
                          width: 300,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              // errorText: STATUS_dropdown == "false"
                              //     ? ERRORTEXT_dropdown
                              //     : "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text("Select a Domain"),
                                value: currentSelectedValue,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedValue = newValue.toString();
                                  });
                                  print(currentSelectedValue);
                                },
                                items: domainList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 15, 15, 15),
                  child: Container(
                    width: 250,
                    child: TextField(
                      controller: CONTROLLER_duration,
                      onChanged: (value) {
                        duration = value.toString();
                        String s = start_time ;
                        var s_DT = DateFormat("yyyy-MM-dd HH:mm:ss", "en_US").parse(s);
                        print(s_DT);


                        // int d = int.parse("40");
                        int d = int.parse(duration);

                        var e_DT = s_DT.add(Duration(minutes:d));
                        print(e_DT);
                        end_time=e_DT;
                      },
                      decoration: InputDecoration(
                        labelText: LABELTEXT_duration,
                        hintText: "Type something.",
                        hintStyle: TextStyle(height: 2),
                        errorText: STATUS_duration == "false"
                            ? ERRORTEXT_duration
                            : null,
                      ),
                    ),
                  ),
                ),
              ]),

              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                      "Click on the button below, to submit the meeting's link.",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(children: <Widget>[
                  // TextButton(
                  //     child:Text('CREATE ZOOM MEETING'),

                  Spacer(),
                  Spacer(),
                  IconButton(
                    icon: Image.asset('assets/images/logo_gmeet.png'),
                    iconSize: 100,
                    onPressed: () {
                      setState(() {
                        CONTROLLER_topic.text.isEmpty
                            ? STATUS_topic = "false"
                            : STATUS_topic = "true";
                        CONTROLLER_start_time.text.isEmpty
                            ? STATUS_start_time = "false"
                            : STATUS_start_time = "true";
                        CONTROLLER_duration.text.isEmpty
                            ? STATUS_duration = "false"
                            : STATUS_duration = "true";
                        // currentSelectedValue == ""
                        //     ? STATUS_dropdown = "false"
                        //     : STATUS_dropdown = "true";
                        print(STATUS_topic +
                            STATUS_start_time +
                            STATUS_duration +
                            STATUS_dropdown);
                        STATUS_topic == "true" &&
                            STATUS_start_time == "true" &&
                            STATUS_duration == "true" &&
                            STATUS_dropdown == "true"

                            ? () async {
                          platform = "gmeet";
                          zoomStatus="true";
                          // try {
                          //   url =
                          //       'http://tempflask.herokuapp.com/api?platform=' +
                          //           platform +
                          //           '&topic=' +
                          //           topic +
                          //           '&start_time=' +
                          //           start_time +
                          //           '&duration=' +
                          //           duration +
                          //           '&JWT_TOKEN=' +
                          //           JWT_TOKEN;
                          //   print(url);
                          //   Data = await Getdata(Uri.parse(url));
                          //   print(Data);
                          //   var DecodedData = jsonDecode(Data);
                          //   zoomStatus = DecodedData['status'];
                          //   print("Zoom Status :" + zoomStatus);
                          //   if (zoomStatus == "true") {
                          //     setState(() {
                          //       zoomLink = DecodedData['link'];
                          //       zoomText =
                          //       "Meeting schedule successful via Gmeet.";
                          //     });
                          //   } else if (zoomStatus == "false") {
                          //     setState(() {
                          //       zoomText =
                          //       "Oops, the Gmeet Widget failed to work.";
                          //     });
                          //   }
                          // } catch (error) {
                          //   setState(() {
                          //     zoomText =
                          //     "Sorry, the server is failing to respond at the moment. Please try later.";
                          //   });
                          // }
                          launchURL('https://meet.google.com/');


                        }()
                            : null;
                      });
                    },
                  ),
                  Spacer(),
                  Spacer(),

                ]),
              ),

              // Text(zoomLink),
              platform == "zoom"
                  ? Padding(
                  padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                  child: zoomStatus == "false"
                      ? Text(
                    zoomText + "  " + zoomMessage,
                    style: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  )
                      : zoomStatus == "true"
                      ? Column(
                    children: [
                      Text(
                        zoomText +
                            "  " +
                            zoomLink +
                            "  " +
                            zoomPassword,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      RaisedButton(
                        onPressed: () {
                          launchURL(zoomLink);
                        },
                        child: Text('Open Zoom Meeting'),
                      ),
                    ],
                  )
                      : Text(
                    zoomText,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ))
                  : Padding(
                  padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                  child: zoomStatus == "false"
                      ? Text(
                    zoomText,
                    style: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  )
                      : zoomStatus == "true"
                      ? Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: 250,
                              child: TextField(
                                controller: CONTROLLER_link,
                                onChanged: (value) {
                                   setState(() {
                                     link = value.toString();
                                   });
                                },
                                decoration: InputDecoration(
                                  labelText: LABELTEXT_link,
                                  hintText: "Type something.",
                                  hintStyle: TextStyle(height: 2),
                                  errorText: STATUS_link == "false"
                                      ? ERRORTEXT_link
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          RaisedButton(
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
                                  borderRadius:
                                  BorderRadius.circular(18.0)),
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () async{
                                setState(() {
                                  CONTROLLER_link.text.isEmpty
                                      ? STATUS_link = "false"
                                      : STATUS_link = "true";
                                });

                                var conn =await MySqlConnection.connect(settings);
                                var r=await conn.query(sql,[widget.user,topic,currentSelectedValue,start_time.toString(),end_time.toString(),duration.toString(),link,platform]);
                                conn.close();
                                Navigator.pop(context,'b');
                              }),
                        ],
                      ),
                    ],
                  )
                      : Text(
                    zoomText,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
