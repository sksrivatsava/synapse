import 'package:flutter/material.dart';
import 'package:synapse/organiser_home.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class analytics_per_event extends StatefulWidget {
  final event_id;
  final user;
  final conn;
  analytics_per_event(this.event_id,this.user,this.conn);
  @override
  _analytics_per_eventState createState() => _analytics_per_eventState();
}

class chart{
  String x;
  int y;
  chart(this.x,this.y);

}
class _analytics_per_eventState extends State<analytics_per_event> {

  List<chart> age=[];
  List<chart> occupation=[];
  List<chart> present_qualification=[];
  List<chart> college=[];
  List<chart> branch=[];
  List<chart> spare=[];
  var op='occupation';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async{
    var agedict={};
    var occupationdict={};
    var present_qualificationdict={};
    var collegedict={};
    var branchdict={};
    var r=await widget.conn.query('select CONCAT(CONVERT(FLOOR(FLOOR(FLOOR(DATEDIFF(CURRENT_DATE , a.attendee_dob)/365)/10)-1)*10,CHAR),"-",CONVERT(FLOOR(FLOOR(DATEDIFF(CURRENT_DATE , a.attendee_dob)/365)/10)*10,CHAR)) AS SOMETHING,a.attendee_occupation,a.attendee_present_qualification,a.attendee_college,a.attendee_branch from registration r inner join attendee a on r.attendee_id=a.attendee_id where r.event_id=? and r.join_status=1',[widget.event_id]);
    for(var i in r){
      if(agedict.containsKey(i[0])){
        agedict[i[0]]+=1;

      }
      else{
        agedict[i[0]]=1;
      }
      if(occupationdict.containsKey(i[1])){
        occupationdict[i[1]]+=1;
      }
      else{
        occupationdict[i[1]]=1;
      }

      if(present_qualificationdict.containsKey(i[2])){
        present_qualificationdict[i[2]]+=1;
      }
      else{
        present_qualificationdict[i[2]]=1;
      }

      if(collegedict.containsKey(i[3])){
        collegedict[i[3]]+=1;
      }
      else{
        collegedict[i[3]]=1;
      }

      if(branchdict.containsKey(i[4])){
        branchdict[i[4]]+=1;
      }
      else{
        branchdict[i[4]]=1;
      }

    }
    setState(() {
      agedict.forEach((k, v) => age.add(chart(k,v)));
      occupationdict.forEach((k, v) => occupation.add(chart(k,v)));
      present_qualificationdict.forEach((k, v) => present_qualification.add(chart(k,v)));
      collegedict.forEach((k, v) => college.add(chart(k,v)));
      branchdict.forEach((k, v) => branch.add(chart(k,v)));
      spare=List.from(occupation);

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics for ${widget.event_id}'),
        actions: [
          DropdownButton<String>(
            value: op,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                op = newValue!;
                if(op=='occupation'){
                  spare=List.from(occupation);
                }
                else if(op=='present_qualification'){
                  spare=List.from(present_qualification);
                }
                else if(op=='college'){
                  spare=List.from(college);
                }
                else if(op=='branch'){
                  spare=List.from(branch);
                }
                else{
                  spare=List.from(age);
                }
              });
            },
            items: <String>['occupation', 'present_qualification','college','branch','age']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 60, 60, 20),
              child: SfCircularChart(
                  legend: Legend(isVisible: true),
                  series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<chart, String>(
                        dataSource: spare,
                        // pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (chart data, _) => data.x,
                        yValueMapper: (chart data, _) => data.y,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside))
                  ]),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20, 60, 60, 20),
              child: SfCartesianChart(
                legend: Legend(isVisible: true),
                series: <ChartSeries>[
                  ColumnSeries<chart, String>(
                    dataSource: spare,
                    // pointColorMapper: (chart data, _) => data.color,
                    xValueMapper: (chart data, _) => data.x,
                    yValueMapper: (chart data, _) => data.y,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    width: 0.8, // Width of the columns
                    spacing: 0.2,
                    // Spacing between the columns
                  )
                ],
                primaryXAxis: CategoryAxis(),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
