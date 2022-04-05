import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fractal/feature/balance_plan/balance_screen_plan_day.dart';
import 'package:fractal/feature/data/database.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ResultClusterList extends StatefulWidget {
  ResultClusterList({Key? key, required this.period}) : super(key: key);
  late double period;
  @override
  _ResultClusterListState createState() => new _ResultClusterListState();
}

class _ResultClusterListState extends State<ResultClusterList> {
  Query? _query;
  @override
  void initState() {
    // print("RESULT CLUSTER LIST ${Database.queryClustersResult1().then((value) => value.once().then((value) => value))}");
    Database.queryClustersResult().then((Query? query) {
      setState(() {
        _query=query!;

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Widget body = new ListView(
      children: <Widget>[
        new ListTile(
          title: Column(children: [
            Row(children: [
              Container(child: Text("Выбрать из шаблонов"),),
              Container(child:IconButton (
                  icon:  Image.asset("images/_zerClustAdd_41X41.png",width: 90,height: 90,scale: 1,),
                  onPressed: () {

                  }
              ))
            ],),
            Row(children: [
              Container(child: Text("Создать новый сектор"),),
              Container(child:IconButton (
                  icon:  Image.asset("images/_zerClustAdd_41X41.png",width: 90,height: 90,scale: 1,),
                  onPressed: () {

                  }
              ))
            ],)
          ],),
        )
      ],
    );

    Future<List<CharNeedResult>?> getDataChList(int period) async {
      List<CharNeed>? planResult= await Database.getCharNeeds();
      List<CharNeed>? tempResult= await Database.getResultCharNeeds(period);
      // List<CharNeed>? weekResult= await Database.getResultCharNeedsWeek(period);
      List<CharNeedResult>? result= [];
      double sum=0;
      double plan=0;
      var temp=tempResult!.groupListsBy((element) => element.name);
      temp.forEach((key, value) {
        for (var j=0; j<value.length;j++){
          sum=sum+value.elementAt(j).value;
        }
        result.add(CharNeedResult(sum, planResult!.firstWhere((element) => element.name==key).value*1440/100, key, value.first.color));
        sum=0;
      });
      return result;
    }
    Widget _futureBuilder() {
      return FutureBuilder(
        future: getDataChList(widget.period.toInt()),
        builder: (BuildContext context, AsyncSnapshot<List<CharNeedResult>?> snapshot) {
          if (!snapshot.hasData) {
            return Align(
              alignment: Alignment.topCenter,
              child: Text("Нет выполненных секторов"),
            );
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              final ComplClust = Column(
                children: <Widget>[
                  ListTile(
                    title: Container(
                        child: Row(
                            children: [
                              Container(
                                  child: Text('${data.elementAt(index).name}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Color.fromRGBO(1, 1, 1, 1.0) ,
                                          letterSpacing: 0,
                                          fontSize: 19.8,
                                          height: 1,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "fonts/Cuprum.ttf")),
                                  width: 100
                              ),
                              Container(
                                  height: 42,
                                  width: 164,
                                  child:Column(
                                      children: <Widget> [
                                        Text("${data.elementAt(index).value~/60.round()} ч. ${(data.elementAt(index).value%60).toStringAsFixed(0)} мин.            "+
                                            (data.elementAt(index).value*100/(data.elementAt(index).plan*widget.period)).toStringAsFixed(2) + "%",
                                            style: TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "fonts/Cuprum.ttf",
                                                fontSize: 12.6,fontWeight:FontWeight.w600)
                                        ),
                                        SizedBox(
                                            width: 164,
                                            height: 26,
                                            child: Container(
                                              padding: EdgeInsets.only(left: 0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4.5),
                                                  border: Border(
                                                    top: BorderSide(width: 1.0, color: Color(0xEB8D8D8D)),
                                                    bottom: BorderSide(width: 1.0, color: Color(0xEB8D8D8D)),
                                                    left: BorderSide(width: 1.0, color: Color(0xEB8D8D8D)),
                                                    right: BorderSide(width: 1.0, color: Color(0xEB8D8D8D)),
                                                  )
                                              ),
                                              child:
                                              StepProgressIndicator(
                                                totalSteps: 32,
                                                currentStep: ((32*((data.elementAt(index).value*100)/(data.elementAt(index).plan*widget.period)))/100).round(),
                                                size: 22,
                                                padding: 0.5,
                                                selectedColor: Colors.yellow,
                                                unselectedColor: Colors.cyan,
                                                roundedEdges: Radius.circular(4.5),
                                                selectedGradientColor: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [data.elementAt(index).color, data.elementAt(index).color],
                                                ),
                                                unselectedGradientColor: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [Colors.white, Colors.white],
                                                ),
                                              ),
                                              // LinearPercentIndicator(
                                              //   animation: true,
                                              //   padding: EdgeInsets.only(right: 5),
                                              //   animationDuration: 600,
                                              //   lineHeight: 17.5,
                                              //   width: 140,
                                              //   percent: ((data.elementAt(index).value*100)/(data.elementAt(index).plan*widget.period))/100,
                                              //   linearStrokeCap: LinearStrokeCap.roundAll,
                                              //   progressColor: data.elementAt(index).color,
                                              // ),
                                            )
                                        ),
                                      ]
                                  )
                              ),
                              ])) ,
                  ),
                  new Divider(
                    height: 0.0,
                  ),
                ],
              );
              return Container(
                child: ComplClust,
                padding: EdgeInsets.only(bottom: 2),
              );
            },
          );
        },
      );
    }
    body=_futureBuilder();
    return new Scaffold(
      body: body,
    );
  }
}
