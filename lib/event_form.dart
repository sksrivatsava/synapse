import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mysql1/mysql1.dart';
import 'connection_settings.dart';
class eventform extends StatefulWidget {
  final user;

  eventform(this.user);
  @override
  _eventformState createState() => _eventformState();
}

class _eventformState extends State<eventform> {
  dynamic event_name;
  dynamic domain_name="ml";
  dynamic start_time;
  dynamic end_time;
  dynamic event_platform="zoom";
  dynamic d={
    'zoom':'https://zoom.us/',
    'gmeet':'https://meet.google.com/',
    'cisco':'https://www.webex.com/'
  };
  dynamic event_link;
  dynamic sql="insert into event(organiser_id,event_name,domain_name,start_time,end_time,duration,event_link,evant_platform) values (?,?,?,?,?,?,?,?)";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('event_form'),

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'event_name',
                      ),
                  onChanged: (ch1){
                        setState(() {
                          event_name=ch1;
                        });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: domain_name,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      domain_name = newValue!;
                    });
                  },
                  items: <String>['ml','ai','data_science','cyber_security','IOT']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    start_time==null?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('start_time'),
                    ):Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(start_time.toString()),
                    ),
                    IconButton(onPressed: (){
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2020, 1, 1),
                          maxTime: DateTime(2030, 1, 1), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            setState(() {
                              start_time=date;
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);

                    }, icon: Icon(Icons.calendar_today))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    end_time==null?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('end_time'),
                    ):Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(end_time.toString()),
                    ),
                    IconButton(onPressed: (){
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2020, 1, 1),
                          maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            setState(() {
                              end_time=date;
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);

                    }, icon: Icon(Icons.calendar_today))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: event_platform,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) async{
                    setState(() {
                      event_platform = newValue!;
                    });
                    if (!await launch(d[event_platform])) throw 'Could not launch ${d[event_platform]}';
                  },
                  items: <String>['zoom', 'gmeet','cisco',]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'event_link',
                  ),
                  onChanged: (ch1){
                    setState(() {
                      event_link=ch1;
                    });
                  },
                ),
              ),
              RaisedButton(
                  child: Text('submit'),
                  onPressed: () async{

                    var oid=widget.user;
                    dynamic duration=end_time.difference(start_time).abs();
                    var conn =await MySqlConnection.connect(settings);
                    var r=await conn.query(sql,[oid,event_name,domain_name,start_time.toString(),end_time.toString(),duration.toString(),event_link,event_platform]);
                    conn.close();
                    Navigator.pop(context,"back");


              })






            ],
          ),
        ),
      ),
    );
  }
}
