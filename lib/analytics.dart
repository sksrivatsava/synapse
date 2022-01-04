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
  String start_time;
  anevent(this.event_name,this.event_id,this.start_time);

}

class line{
  String event_name;
  int no;
  line(this.event_name,this.no);

}
class _analyticsState extends State<analytics> {

  List<anevent> l=[];
  List<line> l2=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdata();
  }
  void getdata() async{
    var conn =await MySqlConnection.connect(settings);
    var r = await conn.query('select event_name,event_id,start_time from event where organiser_id=? and end_time<? order by start_time desc',[widget.user,DateTime.now().toString()]);

    for(var i in r){
      setState(() {
        l.add(anevent(i[0], i[1], i[2].toString()));
      });
    }
    for(var i in l){
      var r1=await conn.query('SELECT COUNT(DISTINCT attendee_id) FROM `registration` where join_status=1 GROUP by event_id having event_id=?',[i.event_id]);
      print(i.event_id);
      for(var j in r1){
        setState(() {
          l2.add(line(i.event_name+'('+i.start_time+')',j[0]));
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
            child: ListView.builder(
                itemCount: l.length,
                controller: ScrollController(),
                itemBuilder: (context,i){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(l[i].event_name),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(l[i].start_time),
                            ),
                            RaisedButton(
                                child: Text('see'),
                                onPressed: (){

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>analytics_per_event(l[i].event_id, widget.user)));
                            })
                          ],
                        ),
                      ),
                    ),
                  );


            }),
          ),
        ],
      ),
    );
  }
}
