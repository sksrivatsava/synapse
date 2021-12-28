import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'connection_settings.dart';
class domain_selection extends StatefulWidget {
  final userid;
  final conn;
  domain_selection(this.userid,this.conn);
  @override
  _domain_selectionState createState() => _domain_selectionState();
}

class dcards{
  String domain;
  bool istap;

  dcards(this.domain,this.istap);
}

class _domain_selectionState extends State<domain_selection> {
  List<dcards> dl=[];
  List l=['ml','ai','data_science','cyber_security','IOT'];
  List ind=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(var i in l){
      
      setState(() {
        dl.add(dcards(i, false));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Domain_selection'),
        actions: [
          Text('submit'),
          IconButton(onPressed: () async{
            for(var i in ind){
              var r=await widget.conn.query('insert into domain(attendee_id,domain_name) values(?,?)',[widget.userid,i]);

            }
            Navigator.pop(context);
          }, icon: Icon(Icons.check))
        ],
      ),

      body: GridView.builder(
          itemCount: dl.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3),

          itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              child: Card(
                child: dl[index].istap?Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.check),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(dl[index].domain),
                    )
                  ],
                ):Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(dl[index].domain),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
              onTap: (){
                setState(() {
                  if(dl[index].istap==false){
                  dl[index].istap=true;
                  ind.add(dl[index].domain);}
                  else{
                    dl[index].istap=false;
                    ind.remove(dl[index].domain);
                  }
                });

              },
            );


          }),
    );
  }
}
