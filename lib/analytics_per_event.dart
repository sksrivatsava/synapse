import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:synapse/organiser_home.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'connection_settings.dart';
const kPrimaryColor = Colors.blueGrey;
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 20.0;
class analytics_per_event extends StatefulWidget {
  final event_id;
  final user;
  final event_name;
  final t;
  analytics_per_event(this.event_id,this.user,this.event_name,this.t);
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
  var isBarClicked = "";
  var isPieClicked = "";
  var isMathClicked = "";
  var typeOfGraph = "Bar Chart";
  var currentSelectedValue="Occupation Status";
  var statFilters = [
    "Age Group",
    "Occupation Status",
    "Present Qualification",
    "College",
    "Branch"
  ];
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
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select CONCAT(CONVERT(FLOOR(FLOOR(FLOOR(DATEDIFF(CURRENT_DATE , a.attendee_dob)/365)/10)-1)*10,CHAR),"-",CONVERT(FLOOR(FLOOR(DATEDIFF(CURRENT_DATE , a.attendee_dob)/365)/10)*10,CHAR)) AS SOMETHING,a.attendee_occupation,a.attendee_present_qualification,a.attendee_college,a.attendee_branch from registration r inner join attendee a on r.attendee_id=a.attendee_id where r.event_id=? and r.join_status=1',[widget.event_id]);
    conn.close();
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Analytics for ${widget.event_id}'),
  //       actions: [
  //         DropdownButton<String>(
  //           value: op,
  //           icon: const Icon(Icons.arrow_downward),
  //           elevation: 16,
  //           style: const TextStyle(color: Colors.deepPurple),
  //           underline: Container(
  //             height: 2,
  //             color: Colors.deepPurpleAccent,
  //           ),
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               op = newValue!;
  //               if(op=='occupation'){
  //                 spare=List.from(occupation);
  //               }
  //               else if(op=='present_qualification'){
  //                 spare=List.from(present_qualification);
  //               }
  //               else if(op=='college'){
  //                 spare=List.from(college);
  //               }
  //               else if(op=='branch'){
  //                 spare=List.from(branch);
  //               }
  //               else{
  //                 spare=List.from(age);
  //               }
  //             });
  //           },
  //           items: <String>['occupation', 'present_qualification','college','branch','age']
  //               .map<DropdownMenuItem<String>>((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(value),
  //             );
  //           }).toList(),
  //         ),
  //       ],
  //     ),
  //
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.fromLTRB(20, 60, 60, 20),
  //             child: SfCircularChart(
  //                 legend: Legend(isVisible: true),
  //                 series: <CircularSeries>[
  //                   // Render pie chart
  //                   PieSeries<chart, String>(
  //                       dataSource: spare,
  //                       // pointColorMapper: (ChartData data, _) => data.color,
  //                       xValueMapper: (chart data, _) => data.x,
  //                       yValueMapper: (chart data, _) => data.y,
  //                       dataLabelSettings: DataLabelSettings(
  //                           isVisible: true,
  //                           labelPosition: ChartDataLabelPosition.outside))
  //                 ]),
  //           ),
  //
  //           Padding(
  //             padding: EdgeInsets.fromLTRB(20, 60, 60, 20),
  //             child: SfCartesianChart(
  //               legend: Legend(isVisible: true),
  //               series: <ChartSeries>[
  //                 ColumnSeries<chart, String>(
  //                   dataSource: spare,
  //                   // pointColorMapper: (chart data, _) => data.color,
  //                   xValueMapper: (chart data, _) => data.x,
  //                   yValueMapper: (chart data, _) => data.y,
  //                   dataLabelSettings: DataLabelSettings(isVisible: true),
  //                   width: 0.8, // Width of the columns
  //                   spacing: 0.2,
  //                   // Spacing between the columns
  //                 )
  //               ],
  //               primaryXAxis: CategoryAxis(),
  //             ),
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //
  //   );
  // }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
              child: SizedBox(
                height: size.height * 0.8,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding * 3),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Spacer(),
                            Text("Statistics",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color.fromRGBO(128, 0, 0, 100))),
                            Spacer(),
                            Container(
                              width: size.width * 0.2,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5.0))),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Text("Select Filter.."),
                                        value: currentSelectedValue,
                                        isDense: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            currentSelectedValue = newValue!;
                                            if(currentSelectedValue=='Occupation Status'){
                                              spare=List.from(occupation);
                                            }
                                            else if(currentSelectedValue=='Age Group'){
                                              spare=List.from(age);
                                            }
                                            else if(currentSelectedValue=='Present Qualification'){
                                              spare=List.from(present_qualification);
                                            }
                                            else if(currentSelectedValue=='College'){
                                              spare=List.from(college);
                                            }
                                            else if(currentSelectedValue=='Branch'){
                                              spare=List.from(branch);
                                            }
                                          });
                                          print(currentSelectedValue);
                                        },
                                        items: statFilters.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isBarClicked = "true";
                                    isPieClicked = "false";
                                    isMathClicked = "false";
                                    typeOfGraph = "Bar Chart";
                                    print(isBarClicked +
                                        "  " +
                                        isPieClicked +
                                        "  " +
                                        isMathClicked);
                                  });
                                },
                                child: IconCard(icon: Icons.bar_chart_sharp)),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isBarClicked = "false";
                                    isPieClicked = "true";
                                    isMathClicked = "false";
                                    typeOfGraph = "Pie Chart";
                                    print(isBarClicked +
                                        "  " +
                                        isPieClicked +
                                        "  " +
                                        isMathClicked);
                                  });
                                },
                                child: IconCard(icon: Icons.pie_chart_sharp)),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isBarClicked = "false";
                                      isPieClicked = "false";
                                      isMathClicked = "true";
                                      typeOfGraph = "Mathematical Stats";
                                      print(isBarClicked +
                                          "  " +
                                          isPieClicked +
                                          "  " +
                                          isMathClicked);
                                    });
                                  },
                                  child: IconCard(
                                      icon:
                                      Icons.format_list_numbered_rtl_sharp)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.8,
                      width: size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(63),
                          bottomLeft: Radius.circular(63),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 60,
                            color: kPrimaryColor.withOpacity(0.29),
                          ),
                        ],
                      ),
                      child: isPieClicked == "true"
                          ? PieChart(data: spare)
                          : BarGraph(data: spare),
                    ),
                  ],
                ),
              ),
            ),
            StatsPageEventTag(
                eventName: "Webinar on ${widget.event_name}",
                eventDateAndTime: "${widget.t}",
                typeOfGraph: typeOfGraph),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }




}

class IconCard extends StatelessWidget {
  IconData icon;
  IconCard({required this.icon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      padding: EdgeInsets.all(kDefaultPadding / 2),
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 22,
            color: kPrimaryColor.withOpacity(0.22),
          ),
          BoxShadow(
            offset: Offset(-15, -15),
            blurRadius: 20,
            color: Colors.white,
          ),
        ],
      ),
      child: Icon(icon),
    );
  }
}

class PieChart extends StatelessWidget {
  List<chart> data;

  PieChart({required this.data});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 60, 60, 20),
      child: SfCircularChart(
          legend: Legend(isVisible: true),
          series: <CircularSeries>[
            // Render pie chart
            PieSeries<chart, String>(
                dataSource: data,
                // pointColorMapper: (chart data, _) => data.color,
                name:'attendee numbers',
                xValueMapper: (chart data, _) => data.x,
                yValueMapper: (chart data, _) => data.y,
                dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside))
          ]),
    );
  }
}

class BarGraph extends StatelessWidget {
  List<chart> data;
  BarGraph({required this.data});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 60, 60, 20),
      child: SfCartesianChart(
        legend: Legend(isVisible: true),
        series: <ChartSeries>[
          ColumnSeries<chart, String>(
            dataSource: data,
            // pointColorMapper: (chart data, _) => data.color,
            name:'attendee numbers',
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
    );
  }
}

class StatsPageEventTag extends StatelessWidget {
  final String eventName;
  final String eventDateAndTime;
  final String typeOfGraph;

  const StatsPageEventTag({
    this.eventName = "",
    this.eventDateAndTime = "",
    this.typeOfGraph = "",
  });

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(eventName,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: kTextColor, fontWeight: FontWeight.bold)),
              Text(
                eventDateAndTime,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
                // style: TextStyle(
                //   fontSize: 20,
                //   color: kPrimaryColor,
                //   fontWeight: FontWeight.w300,
                // )
              ),
            ],
          ),
          Spacer(),
          Text(
            "$typeOfGraph",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: kPrimaryColor),
          )
        ],
      ),
    );
  }
}
