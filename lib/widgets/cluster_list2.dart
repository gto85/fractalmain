
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fractal/data/database.dart';
import 'package:fractal/screens/tasks/edit_task.dart';
import 'package:fractal/widgets/edit_cluster.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class ClusterList2 extends StatefulWidget {
  const ClusterList2({Key? key, required this.period}) : super(key: key);
  final double period;
  @override
  _ClusterList2State createState() => _ClusterList2State();
}

class _ClusterList2State extends State<ClusterList2> {
  Query? _query;
  num test=0;
  @override
  void initState() {

    Database.TimeClusters().then((value) {
      value.once().then((value) {
        Map<dynamic, dynamic> _myMap ;
        // _myMap=value.value;
        _myMap= {};
        _myMap.forEach((key, value) {
          test=test+value["timeCluster"];
          // print("TEST0: $test");
        });
      });

    });

    Database.queryClusters().then((Query? query) {

      setState(() {
        _query = query!;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget planbody = Column();
    Widget body = ListView(
      children: <Widget>[
        ListTile(
          title: Column(children: [
            Row(children: [
              const Text("Выбрать из шаблонов"),
              IconButton (
                  icon:  Image.asset("images/_zerClustAdd_41X41.png"),
                  onPressed: () {

                  }
              )
            ],),
            Row(children: const [

            ],)
          ],),
        )
      ],
    );
    if (_query != null) {

      planbody=Column(children: [
        Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Container(margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "ЗАПЛАНИРОВАННО НА ДЕНЬ:",
                style:TextStyle(
                    letterSpacing:0,
                    fontWeight: FontWeight.w800,
                    fontFamily: "fonts/Cuprum.ttf",
                    fontSize: 14.4279)
              )
            ),
            Row(
              children: [
                Container(
                  width:250,
                    margin: const EdgeInsets.only(left: 15,right: 5),
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(4.5),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [(test*100/1440)/100, 1],
                        colors: const [Colors.white, Colors.white]),
                        border: const Border(
                          top: BorderSide(width: 2.0, color: Color(
                              0xEB8D8D8D)),
                          bottom: BorderSide(width: 2.0, color: Color(0xEB8D8D8D)),
                          left: BorderSide(width: 2.0, color: Color(0xEB8D8D8D)),
                          right: BorderSide(width: 2.0, color: Color(0xEB8D8D8D)),
                        )),
                    child: const StepProgressIndicator(
                              totalSteps: 10,
                              currentStep: 22,
                              size: 13,
                              padding: 1,
                              selectedColor: Colors.yellow,
                              unselectedColor: Colors.cyan,
                              roundedEdges: Radius.circular(4.5),
                              selectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.red, Colors.green],
                              ),
                              unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.white, Colors.white],
                              ),

                    )
                ),
                Text("${test*widget.period~/60.round()} ч. ${test*widget.period%60} мин.",style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)],),
          ],
        ),
        ]
      );
      body = FirebaseAnimatedList(
        query: _query!,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index,
            ) {
          String? clusterKey = snapshot.key;
          var map =  snapshot.value;
          var map1=Map<String, dynamic>.from(map as Map);
          String clusterName = map1['name'];
          int clusterColor = int.parse(map1['color']);
          return  Column(
            children: <Widget>[
              ListTile(
                title: Row(
                    children: [
                      SizedBox(
                        child: Text(clusterName,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: const TextStyle(
                              letterSpacing: 0,
                              fontSize: 19.8,
                              height: 1,
                              fontWeight: FontWeight.w500,
                              fontFamily: "fonts/Cuprum.ttf")),
                        width: 100
                      ),
                      Container(
                        height: 18,
                        width: 170,
                        decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(4.5),
                        color: Color(clusterColor)
                      ),
                        child:Row(
                          children: <Widget> [
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child:SizedBox(
                                width: 105,
                                height: 18,
                                child: Container(padding: const EdgeInsets.only(left: 0),
                                  child: Text("${map1['timeCluster']*widget.period~/60.round()} ч. ${map1['timeCluster']*widget.period%60} мин.",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "fonts/Cuprum.ttf",
                                        fontSize: 12.61,fontWeight:FontWeight.w400)))
                          )),
                            Stack(
                              children:<Widget>[

                              SizedBox(
                                width: 55,
                                height: 18,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(4.5),),
                                  padding: const EdgeInsets.only(left: 1),
                                  child: LinearProgressIndicator(
                                    value: map1['timeCluster']*100/1440,
                                    backgroundColor: const Color(0xFF4DA4FF),
                                    valueColor:AlwaysStoppedAnimation<Color>(Color(clusterColor)),
                                  ),)
                            ),

                              Text(
                                (map1['timeCluster']*100/1440).toStringAsFixed(2)+ "%",textAlign: TextAlign.right,
                                style: const TextStyle(fontFamily: "fonts/Cuprum.ttf",fontSize: 13,color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ]
                      )
                    ]
                )
                ),
                   Container(
                    margin: const EdgeInsets.only(left: 0),
                    child: IconButton (
                        icon: Image.asset("images/_edit_icon.png",width: 20,height: 15),
                      iconSize: 15,
                      onPressed: () {
                        _edit(clusterKey!);
                      }
                  )
                  )]) ,
                onTap: () {
                  // print("map color ${map["color"]}");
                  _editTask(clusterKey!,map1["name"],map1["color"]);
                },
              ),
              const Divider(
                height: 1.0,
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body:Container(
          margin: const EdgeInsets.only(top:10),
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Color(0x65ABABAB)),
              ),
          ),
          child: Stack(
            children: [
              Container(
                child: planbody
            ),
              Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: body
              )

          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset("images/add_icon.png",width: 45,height: 45),
        onPressed: () {
          _createClusters();
        },
      ),
    );
  }
  void _createClusters() {
    Database.createClusters().then((String clusterKey) {
      _edit(clusterKey);
    });
  }
  void _edit(String clusterKey) {
    var route = MaterialPageRoute(
      builder: (context) => EditClusterPage(clusterKey: clusterKey),
    );
    Navigator.of(context).push(route);
  }
  void _editTask(String clusterKey, String nameClust,String edTaskColor) {
    var route = MaterialPageRoute(
      builder: (context) => EditTaskPage(taskKey: clusterKey,nameCluster:nameClust,color:edTaskColor,),
    );
    Navigator.of(context).push(route);
  }
}
