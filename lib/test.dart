// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
//
// //const kPrimaryColor = Color(0xFF0C9869);
// const kPrimaryColor = Colors.blueGrey;
// const kTextColor = Color(0xFF3C4046);
// const kBackgroundColor = Color(0xFFF9F8FD);
//
// const double kDefaultPadding = 20.0;
//
// void main() => runApp(MaterialApp(home: MyApp()));
//
// class MyApp extends StatefulWidget {
//   MyAppState createState() => MyAppState();
// }
//
// class MyAppState extends State {
//   @override
//   final List<ChartData> data = [
//     ChartData('David', 25),
//     ChartData('Steve', 38),
//     ChartData('Jack', 34),
//     ChartData('Others', 52)
//   ];
//
//   var isBarClicked = "";
//   var isPieClicked = "";
//   var isMathClicked = "";
//   var typeOfGraph = "Bar Chart";
//   var currentSelectedValue;
//   var statFilters = [
//     "Age Group",
//     "Occupation Status",
//     "Present Qualification",
//     "College",
//     "Branch"
//   ];
//
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
//               child: SizedBox(
//                 height: size.height * 0.8,
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: kDefaultPadding * 3),
//                         child: Column(
//                           children: <Widget>[
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: IconButton(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: kDefaultPadding),
//                                 icon: const Icon(Icons.arrow_back),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ),
//                             Spacer(),
//                             Text("Statistics",
//                                 style: TextStyle(
//                                     fontSize: 24,
//                                     color: Color.fromRGBO(128, 0, 0, 100))),
//                             Spacer(),
//                             Container(
//                               width: size.width * 0.2,
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//                               child: FormField<String>(
//                                 builder: (FormFieldState<String> state) {
//                                   return InputDecorator(
//                                     decoration: InputDecoration(
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(5.0))),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton<String>(
//                                         hint: Text("Select Filter.."),
//                                         value: currentSelectedValue,
//                                         isDense: true,
//                                         onChanged: (newValue) {
//                                           setState(() {
//                                             currentSelectedValue = newValue;
//                                           });
//                                           print(currentSelectedValue);
//                                         },
//                                         items: statFilters.map((String value) {
//                                           return DropdownMenuItem<String>(
//                                             value: value,
//                                             child: Text(value),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isBarClicked = "true";
//                                     isPieClicked = "false";
//                                     isMathClicked = "false";
//                                     typeOfGraph = "Bar Chart";
//                                     print(isBarClicked +
//                                         "  " +
//                                         isPieClicked +
//                                         "  " +
//                                         isMathClicked);
//                                   });
//                                 },
//                                 child: IconCard(icon: Icons.bar_chart_sharp)),
//                             GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isBarClicked = "false";
//                                     isPieClicked = "true";
//                                     isMathClicked = "false";
//                                     typeOfGraph = "Pie Chart";
//                                     print(isBarClicked +
//                                         "  " +
//                                         isPieClicked +
//                                         "  " +
//                                         isMathClicked);
//                                   });
//                                 },
//                                 child: IconCard(icon: Icons.pie_chart_sharp)),
//                             GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isBarClicked = "false";
//                                     isPieClicked = "false";
//                                     isMathClicked = "true";
//                                     typeOfGraph = "Mathematical Stats";
//                                     print(isBarClicked +
//                                         "  " +
//                                         isPieClicked +
//                                         "  " +
//                                         isMathClicked);
//                                   });
//                                 },
//                                 child: IconCard(
//                                     icon:
//                                     Icons.format_list_numbered_rtl_sharp)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: size.height * 0.8,
//                       width: size.width * 0.75,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(63),
//                           bottomLeft: Radius.circular(63),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             offset: Offset(0, 10),
//                             blurRadius: 60,
//                             color: kPrimaryColor.withOpacity(0.29),
//                           ),
//                         ],
//                       ),
//                       child: isPieClicked == "true"
//                           ? PieChart(data: data)
//                           : BarGraph(data: data),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             StatsPageEventTag(
//                 eventName: "Webinar on Information Security",
//                 eventDateAndTime: "10:00 - 12:00, 14 July 2022",
//                 typeOfGraph: typeOfGraph),
//             SizedBox(height: kDefaultPadding),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ChartData {
//   ChartData(this.x, this.y);
//   final String x;
//   final double y;
// }
//
// class IconCard extends StatelessWidget {
//   IconData icon;
//   IconCard({required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
//       padding: EdgeInsets.all(kDefaultPadding / 2),
//       height: 62,
//       width: 62,
//       decoration: BoxDecoration(
//         color: kBackgroundColor,
//         borderRadius: BorderRadius.circular(6),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 15),
//             blurRadius: 22,
//             color: kPrimaryColor.withOpacity(0.22),
//           ),
//           BoxShadow(
//             offset: Offset(-15, -15),
//             blurRadius: 20,
//             color: Colors.white,
//           ),
//         ],
//       ),
//       child: Icon(icon),
//     );
//   }
// }
//
// class PieChart extends StatelessWidget {
//   List<ChartData> data;
//
//   PieChart({required this.data});
//
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(20, 60, 60, 20),
//       child: SfCircularChart(
//           legend: Legend(isVisible: true),
//           series: <CircularSeries>[
//             // Render pie chart
//             PieSeries<ChartData, String>(
//                 dataSource: data,
//                 // pointColorMapper: (ChartData data, _) => data.color,
//                 xValueMapper: (ChartData data, _) => data.x,
//                 yValueMapper: (ChartData data, _) => data.y,
//                 dataLabelSettings: DataLabelSettings(
//                     isVisible: true,
//                     labelPosition: ChartDataLabelPosition.outside))
//           ]),
//     );
//   }
// }
//
// class BarGraph extends StatelessWidget {
//   List<ChartData> data;
//   BarGraph({required this.data});
//
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(20, 60, 60, 20),
//       child: SfCartesianChart(
//         legend: Legend(isVisible: true),
//         series: <ChartSeries>[
//           ColumnSeries<ChartData, String>(
//             dataSource: data,
//             // pointColorMapper: (ChartData data, _) => data.color,
//             xValueMapper: (ChartData data, _) => data.x,
//             yValueMapper: (ChartData data, _) => data.y,
//             dataLabelSettings: DataLabelSettings(isVisible: true),
//             width: 0.8, // Width of the columns
//             spacing: 0.2,
//             // Spacing between the columns
//           )
//         ],
//         primaryXAxis: CategoryAxis(),
//       ),
//     );
//   }
// }
//
// class StatsPageEventTag extends StatelessWidget {
//   final String eventName;
//   final String eventDateAndTime;
//   final String typeOfGraph;
//
//   const StatsPageEventTag({
//     this.eventName = "",
//     this.eventDateAndTime = "",
//     this.typeOfGraph = "",
//   });
//
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//       child: Row(
//         children: <Widget>[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(eventName,
//                   style: Theme.of(context).textTheme.headline4!.copyWith(
//                       color: kTextColor, fontWeight: FontWeight.bold)),
//               Text(
//                 eventDateAndTime,
//                 style: Theme.of(context).textTheme.headline4!.copyWith(
//                     color: kPrimaryColor,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w300),
//                 // style: TextStyle(
//                 //   fontSize: 20,
//                 //   color: kPrimaryColor,
//                 //   fontWeight: FontWeight.w300,
//                 // )
//               ),
//             ],
//           ),
//           Spacer(),
//           Text(
//             "$typeOfGraph",
//             style: Theme.of(context)
//                 .textTheme
//                 .headline5!
//                 .copyWith(color: kPrimaryColor),
//           )
//         ],
//       ),
//     );
//   }
// }
