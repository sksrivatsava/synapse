import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'connection_settings.dart';
class calendar extends StatefulWidget {
  final user;
  calendar(this.user);
  @override
  _calendarState createState() => _calendarState();
}

class _calendarState extends State<calendar> {
List<Meeting> l=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void getdata() async{
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select r.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.evant_platform,e.end_time from registration r inner join event e on e.event_id=r.event_id inner join organiser o on e.organiser_id=o.organiser_id where r.attendee_id=? and e.end_time<?',[widget.user,DateTime.now().toString()]);
    for(var i in r){
      setState(() {
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[6].year,i[6].month,i[6].day,i[6].hour,i[6].minute,i[6].second);

        l.add(Meeting(i[1]+' by '+i[3]+' on '+i[5], st, et, Colors.grey, false));

      });
    }
   r=await conn.query('select r.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.evant_platform,e.end_time from registration r inner join event e on e.event_id=r.event_id inner join organiser o on e.organiser_id=o.organiser_id where r.attendee_id=? and e.start_time<=? and e.end_time>=?',[widget.user,DateTime.now().toString(),DateTime.now().toString()]);
    for(var i in r){
      setState(() {
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[6].year,i[6].month,i[6].day,i[6].hour,i[6].minute,i[6].second);
        l.add(Meeting(i[1]+' by '+i[3]+' on '+i[5], st, et, Colors.green, false));
      });
    }
    r=await conn.query('select r.event_id,e.event_name,e.domain_name,o.organiser_channel_name,e.start_time,e.evant_platform,e.end_time from registration r inner join event e on e.event_id=r.event_id inner join organiser o on e.organiser_id=o.organiser_id where r.attendee_id=? and e.start_time>?',[widget.user,DateTime.now().toString()]);
    for(var i in r){
      setState(() {
        dynamic st=DateTime(i[4].year,i[4].month,i[4].day,i[4].hour,i[4].minute,i[4].second);
        dynamic et=DateTime(i[6].year,i[6].month,i[6].day,i[6].hour,i[6].minute,i[6].second);
        l.add(Meeting(i[1]+' by '+i[3]+' on '+i[5], st, et, Colors.orange, false));
      });
    }
    conn.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
        body: SfCalendar(

          view: CalendarView.month,
          dataSource: MeetingDataSource(l),
          monthViewSettings: MonthViewSettings(

            showAgenda: true,
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment

          ),
        ));
  }

}
List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  // today.s
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
