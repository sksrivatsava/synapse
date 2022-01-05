import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:synapse/analytics_per_event.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'connection_settings.dart';

class analytics extends StatefulWidget {
  final user;

  analytics(this.user);
  @override
  _analyticsState createState() => _analyticsState();
}

class anevent{
  String event_name;
  int event_id;
  DateTime start_time;
  DateTime end_time;
  String event_platform;
  anevent(this.event_name,this.event_id,this.start_time,this.end_time,this.event_platform);

}

class line{
  String event_name;
  int no;
  line(this.event_name,this.no);

}
class _analyticsState extends State<analytics> {

  List<anevent> l=[];
  List<line> l2=[];
  var d={
    1:"January",
    2:"February",
    3:"March",
    4:"April",
    5:"May",
    6:"June",
    7:"July",
    8:"August",
    9:"September",
    10:"October",
    11:"November",
    12:"December"
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdata();
  }
  void getdata() async{
    var conn =await MySqlConnection.connect(settings);
    var r = await conn.query('select event_name,event_id,start_time,end_time,evant_platform from event where organiser_id=? and end_time<? order by start_time desc',[widget.user,DateTime.now().toString()]);

    for(var i in r){
      setState(() {
        dynamic st=DateTime(i[2].year,i[2].month,i[2].day,i[2].hour,i[2].minute,i[2].second);
        dynamic et=DateTime(i[3].year,i[3].month,i[3].day,i[3].hour,i[3].minute,i[3].second);
        l.add(anevent(i[0], i[1], st,et,i[4]));
      });
    }
    for(var i in l){
      var r1=await conn.query('SELECT COUNT(DISTINCT attendee_id) FROM `registration` where join_status=1 GROUP by event_id having event_id=?',[i.event_id]);
      print(i.event_id);
     if(r1.isNotEmpty) {
       for (var j in r1) {
         setState(() {
           l2.add(
               line(i.event_name + '(' + "${i.start_time.hour.toString()}:${i.start_time.minute.toString()} - ${i.end_time.hour.toString()}:${i.end_time.minute.toString()}, ${i.start_time.day.toString()}th ${d[i.start_time.month]} ${i.start_time.year}" + ')', j[0]));
         });
       }
     }
     else{
       setState(() {
         l2.add(
             line(i.event_name + '(' + "${i.start_time.hour.toString()}:${i.start_time.minute.toString()} - ${i.end_time.hour.toString()}:${i.end_time.minute.toString()}, ${i.start_time.day.toString()}th ${d[i.start_time.month]} ${i.start_time.year}" + ')', 0));
       });
     }

    }
    conn.close();
    setState(() {
      l2=List.from(l2.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'No .of attendess per event'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<line, String>>[
                  LineSeries<line, String>(
                      dataSource: l2,
                      xValueMapper: (line sales, _) => sales.event_name,
                      yValueMapper: (line sales, _) => sales.no,
                      name: 'attendees number',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
          ),
          Expanded(
            // child: ListView.builder(
            //     itemCount: l.length,
            //     controller: ScrollController(),
            //     itemBuilder: (context,i){
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Card(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Column(
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(l[i].event_name),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(l[i].start_time),
            //                 ),
            //                 RaisedButton(
            //                     child: Text('see'),
            //                     onPressed: (){
            //
            //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>analytics_per_event(l[i].event_id, widget.user)));
            //                 })
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //
            //
            // }),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: l.length,
              padding: EdgeInsets.all(40),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 50.0 / 10.0,
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20),
              itemBuilder: (BuildContext context, int i) {
                return Container(
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
                              child: Text("Webinar on ${l[i].event_name}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Color.fromRGBO(128, 0, 0, 100),
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              padding: EdgeInsets.all(1.0),
                              child: Row(children: [
                                Text("Presented on ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(128, 0, 0, 100),
                                    )),
                                Text("${l[i].event_platform}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(128, 0, 0, 100),
                                        fontWeight: FontWeight.bold))
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(1.0),
                              child: Text("${l[i].start_time.hour.toString()}:${l[i].start_time.minute.toString()} - ${l[i].end_time.hour.toString()}:${l[i].end_time.minute.toString()}, ${l[i].start_time.day.toString()}th ${d[l[i].start_time.month]} ${l[i].start_time.year}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(128, 0, 0, 100),
                                      fontWeight: FontWeight.bold)),
                            ),
                          ]),
                      Spacer(),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            TextButton(
                                child: Text('SEE'),
                                onPressed: () async{
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>analytics_per_event(l[i].event_id, widget.user,l[i].event_name,"${l[i].start_time.hour.toString()}:${l[i].start_time.minute.toString()} - ${l[i].end_time.hour.toString()}:${l[i].end_time.minute.toString()}, ${l[i].start_time.day.toString()}th ${d[l[i].start_time.month]} ${l[i].start_time.year}")));

                                },
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        decorationColor: Colors.red)))
                          ])
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
