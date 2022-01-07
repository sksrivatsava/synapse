import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:synapse/connection_settings.dart';
class attendee_edit_domain extends StatefulWidget {
  final user;
  attendee_edit_domain(this.user);
  @override
  _attendee_edit_domainState createState() => _attendee_edit_domainState();
}

class edcards{
  String domain;
  bool istap;

  edcards(this.domain,this.istap);
}

class _attendee_edit_domainState extends State<attendee_edit_domain> {
  List<edcards> dl=[];
  List l=[ "Machine Learning",
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
    "Innovation and Design Thinking"];
  List ind=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void getdata() async{
    var conn =await MySqlConnection.connect(settings);
    var r=await conn.query('select domain_name from domain where attendee_id=?',[widget.user]);
    conn.close();
    for(var i in r){
      ind.add(i[0]);
    }

    for(var i in l){
      if(ind.contains(i)){
        setState(() {
          dl.add(edcards(i, true));
        });
      }
      else{
        setState(() {
          dl.add(edcards(i, false));
        });
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: SizedBox(
        width: 200,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text('Submit and Proceed'),
          onPressed: (){
            Navigator.pop(context,"back");
          },
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 10),
            child: Text("Choose all domains you're interested in.",
                style: TextStyle(
                    color: Color.fromRGBO(128, 0, 0, 100), fontSize: 42)),
          ),
          Expanded(
            child: GridView.builder(
                itemCount: dl.length,
                padding: EdgeInsets.all(40),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 30.0 / 10.0,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                        Orientation.portrait)
                        ? 2
                        : 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Card(
                      child: dl[index].istap
                          ? Column(
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
                      )
                          : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(dl[index].domain),
                            ),
                          ]),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),

                    onTap: () async{

                      if(dl[index].istap==false){
                        var conn =await MySqlConnection.connect(settings);
                        var r=await conn.query('insert into domain(attendee_id,domain_name) values(?,?)',[widget.user,dl[index].domain]);
                        conn.close();
                        setState(() {
                          dl[index].istap=true;
                        });
                      }
                      else{
                        var conn =await MySqlConnection.connect(settings);
                        var r=await conn.query('delete from domain where attendee_id=? and domain_name=?',[widget.user,dl[index].domain]);
                        conn.close();
                        setState(() {
                          dl[index].istap=false;
                        });

                      }


                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
