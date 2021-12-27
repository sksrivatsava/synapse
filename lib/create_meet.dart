import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'API.dart';
class create_meet extends StatefulWidget {
  @override
  _create_meetState createState() => _create_meetState();
}

class _create_meetState extends State<create_meet> {
  String url = '';

  var Data;

  String topic = '';
  String start_time = '';
  String duration = '';
  String JWT_TOKEN =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOm51bGwsImlzcyI6IkpUOEw1eklGU2tLNk1Kdml4cVpXTXciLCJleHAiOjE2NzE4ODY2MjAsImlhdCI6MTY0MDM1MDA5OX0.twIT019QmQeSYi6X4pp6zNlIcjnOCEAbIbBIsGNmsxs";

  dynamic selectedDateTime;

  String LABELTEXT_topic = 'Enter the subject of the meeting to be scheduled.';
  String LABELTEXT_start_time = 'Select the start time of the meeting.';
  String LABELTEXT_duration = 'Enter the duration of the meeting in minutes.';

  String ERRORTEXT_topic =
      "Please DO NOT leave this field blank. Enter the subject of the meeting.";
  String ERRORTEXT_start_time =
      "Please select a valid time and date from the calendar.";
  String ERRORTEXT_duration =
      "Please DO NOT leave this field blank. Enter a valid duration in minutes.";

  TextEditingController CONTROLLER_topic = TextEditingController();
  TextEditingController CONTROLLER_start_time = TextEditingController();
  TextEditingController CONTROLLER_duration = TextEditingController();

  var STATUS_topic = "";
  var STATUS_start_time = "";
  var STATUS_duration = "";

  var platform = "";
  String zoomStatus = '';
  String zoomLink = '';
  String zoomPassword = '';
  String zoomMessage = '';
  String zoomText = 'Powered by Zoom API/Selenium';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom Meeting Creation Wizard'),
      ),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: CONTROLLER_duration,
              onChanged: (value) {
                duration = value.toString();
              },
              decoration: InputDecoration(
                labelText: LABELTEXT_duration,
                hintText: "Type something.",
                hintStyle: TextStyle(height: 2),
                errorText:
                STATUS_duration == "false" ? ERRORTEXT_duration : null,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: <Widget>[
              TextButton(
                  child: Text('CREATE ZOOM MEETING'),
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
                      print(STATUS_topic + STATUS_start_time + STATUS_duration);
                      STATUS_topic == "true" &&
                          STATUS_start_time == "true" &&
                          STATUS_duration == "true" &&
                          zoomStatus != "true"
                          ? () async {
                        platform = "zoom";
                        url = 'http://tempflask.herokuapp.com/api?platform=' +
                            platform +
                            '&topic=' +
                            topic +
                            '&start_time=' +
                            start_time +
                            '&duration=' +
                            duration +
                            '&JWT_TOKEN=' +
                            JWT_TOKEN;
                        print(url);
                        Data = await Getdata(Uri.parse(url));
                        print(Data);
                        var DecodedData = jsonDecode(Data);
                        zoomStatus = DecodedData['status'];
                        print("Zoom Status :" + zoomStatus);
                        if (zoomStatus == "true") {
                          setState(() {
                            zoomLink = DecodedData['link'];
                            zoomPassword = DecodedData['password'];
                            zoomText = "Meeting schedule successful!";
                          });
                        } else if (zoomStatus == "false") {
                          setState(() {
                            zoomMessage = DecodedData['message'];
                            zoomText = "Oops, the API failed to work.";
                          });
                        }
                      }()
                          : setState(() {
                        zoomText =
                        "NOT ALLOWED. Meeting already scheduled using Gmeet.";
                      });
                    });
                  },
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decorationColor: Colors.white))),
              Spacer(),
              Spacer(),
              TextButton(
                  child: Text('CREATE GMEET'),
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
                      print(STATUS_topic + STATUS_start_time + STATUS_duration);
                      STATUS_topic == "true" &&
                          STATUS_start_time == "true" &&
                          STATUS_duration == "true" &&
                          zoomStatus != "true"
                          ? () async {
                        platform = "gmeet";
                        url = 'http://127.0.0.1:5000/api?platform=' +
                            platform +
                            '&topic=' +
                            topic +
                            '&start_time=' +
                            start_time +
                            '&duration=' +
                            duration +
                            '&JWT_TOKEN=' +
                            JWT_TOKEN;
                        print(url);
                        Data = await Getdata(Uri.parse(url));
                        print(Data);
                        var DecodedData = jsonDecode(Data);
                        zoomStatus = DecodedData['status'];
                        print("Zoom Status :" + zoomStatus);
                        if (zoomStatus == "true") {
                          setState(() {
                            zoomLink = DecodedData['link'];
                            zoomText =
                            "Meeting schedule successful via Gmeet.";
                          });
                        } else if (zoomStatus == "false") {
                          setState(() {
                            zoomText =
                            "Oops, the Gmeet Widget failed to work.";
                          });
                        }
                      }()
                          : setState(() {
                        zoomText =
                        "NOT ALLOWED. Meeting already scheduled using Zoom.";
                      });
                      ;
                    });
                  },
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decorationColor: Colors.white))),
            ]),
          ),

          // Text(zoomLink),
          platform == "zoom"
              ? Padding(
              padding: const EdgeInsets.all(15.0),
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
                    fontSize: 15.0, fontWeight: FontWeight.bold),
              ))
              : Padding(
              padding: const EdgeInsets.all(15.0),
              child: zoomStatus == "false"
                  ? Text(
                zoomText,
                style: TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold),
              )
                  : zoomStatus == "true"
                  ? Column(
                children: [
                  Text(
                    zoomText + "  " + zoomLink,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  RaisedButton(
                    onPressed: () {
                      launchURL(zoomLink);
                    },
                    child: Text('Open Gmeet'),
                  ),
                ],
              )
                  : Text(
                zoomText,
                style: TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
  void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
