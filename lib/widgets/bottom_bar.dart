
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fractal/notifications.dart';
import 'package:fractal/widgets/balance_screen_plan_day.dart';
import 'package:fractal/widgets/calendar.dart';
import 'package:fractal/widgets/cluster_list2.dart';
import 'package:fractal/widgets/radar_charts.dart';
import 'package:fractal/widgets/result_list_in_time.dart';
import 'package:o_color_picker/o_color_picker.dart';

class MyBalanceResult extends StatelessWidget {
  const MyBalanceResult({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightTabBar4=0;
    double heightPieTop=265;
    double heightKalendTop=35;
    double heightListCluster=185;
    if (height>640)
    {
      heightTabBar4=0;
      heightPieTop=254;
      heightKalendTop=15;
      heightListCluster=230;
    }

    return Scaffold(
        body: Center(
          child:Stack(
            children: <Widget>[
              DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    floatingActionButton: Center(
                        child:Container(width: 280,margin: EdgeInsets.only(left: 30,top: heightTabBar4),height: 26,
                            child: TabBar(
                                labelPadding: const EdgeInsets.all(0),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.blueAccent,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.47),
                                  color: const Color(0xFF0077EF),
                                ),
                                tabs : [
                                  Tab(
                                      child:OverflowBox(
                                          minWidth: 0.0,
                                          maxWidth: 55.0,
                                          minHeight: 0.0,
                                          maxHeight: 24.0,
                                          child:Container(
                                            margin: const EdgeInsets.only(left: 5 ,top: 0.0,bottom: 0.0,right: 2.5),
                                            height: 24,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2.47),
                                              border: const Border(
                                                  top: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                                  left: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                                  right: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                                  bottom: BorderSide(width: 1.0, color: Color(0xFF0077EF))),
                                            ),
                                            child: const Text( "День",style: TextStyle(fontSize: 16.33,fontFamily: "assets/fonts/Cuprum.ttf",letterSpacing: 0)),
                                          )
                                      )
                                  ),
                                  Tab(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 2.5,right: 2.5 ),
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2.47),
                                        border: const Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            left: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            right: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFF0077EF))),
                                      ),
                                      child: const Text( "Неделя",style: TextStyle(fontSize: 16.33,fontFamily: "assets/fonts/Cuprum.ttf",letterSpacing: 0)),
                                    ),
                                  ),
                                  Tab( child:
                                  Container(
                                    margin: const EdgeInsets.only(left: 2.5,right: 2.5,top: 0 ),
                                    height: 24,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.47),
                                      border: const Border(
                                          top: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                          left: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                          right: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                          bottom: BorderSide(width: 1.0, color: Color(0xFF0077EF))),
                                    ),
                                    child: const Text( "Месяц",style: TextStyle(fontSize: 16.33,fontFamily: "assets/fonts/Cuprum.ttf",letterSpacing: 0)),
                                  ),
                                  ),
                                  Tab(
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.only(left: 2.5,right: 2.5 ),
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2.47),
                                        border: const Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            left: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            right: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFF0077EF))),
                                      ),
                                      child: const Text( "Год",style: TextStyle(fontSize: 16.33,fontFamily: "assets/fonts/Cuprum.ttf",letterSpacing: 0)),
                                    ),
                                  ),
                                ] /* End TabBar.tabs. */
                            )
                        )
                    ),
                    body: TabBarView(
                      children: [
                        Column(children: [
                          Stack(children: [Container(
                              padding: const EdgeInsets.only(top:2,left: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset("assets/images/procent_icon.png"),
                                  Image.asset("assets/images/share_icon.png"),
                                ],
                              )
                          ),
                            SizedBox(height: heightPieTop,
                              child: MyRadarCharts(period: 1,),
                            ),
                            Container(margin: const EdgeInsets.only(top: 120),
                              child:Row(
                                // verticalDirection: VerticalDirection.down,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {},),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () {},),]) ,),
                          ]),
                          Container(margin:EdgeInsets.only(top: heightKalendTop),child:Row( mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(Icons.arrow_back_ios, size: 19, color: Colors.black),
                                Text(
                                    DateTime.now().day.toString()+
                                        " "+retMonth(DateTime.now().month)+
                                        ", "+retDay(DateTime.now().weekday),style: const TextStyle(fontSize: 19,fontWeight:FontWeight.w400,fontFamily: "assets/fonts/Cuprum.ttf")),
                                const Icon(Icons.arrow_forward_ios, size: 19, color: Colors.black,)]),
                          ),
                          Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 60,
                                  minHeight: 60,
                                  maxWidth: 360,
                                  maxHeight: heightListCluster,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: ResultClusterList(period: 1,),
                                ),
                              )
                          )
                        ]),
                        Column(children: [
                          Stack(children: [
                            Container(
                                padding: const EdgeInsets.only(top:2,left: 15,right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.asset("assets/images/procent_icon.png"),
                                    Image.asset("assets/images/share_icon.png"),
                                  ],
                                )
                            ),
                            SizedBox(height: heightPieTop,
                              child:MyRadarCharts(period: 7,),
                            ),
                            Container(margin: const EdgeInsets.only(top: 120),
                              child:Row(
                                // verticalDirection: VerticalDirection.down,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {},),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () {},),]) ,),
                          ]),
                          Container(margin:EdgeInsets.only(top: heightKalendTop),child:Row( mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(Icons.chevron_left_outlined, size: 19, color: Colors.black),
                                Text(
                                    DateTime.now().subtract(const Duration(days: 7)).add(const Duration(hours: 7)).day.toString()+" "+
                                        retMonth(DateTime.now().subtract(const Duration(days: 7)).add(const Duration(hours: 7)).month)+
                                        "---"+
                                        DateTime.now().add(const Duration(hours: 7)).day.toString()+" "+
                                        retMonth(DateTime.now().add(const Duration(hours: 7)).month),
                                    style: const TextStyle(fontSize: 19,fontWeight:FontWeight.w400,fontFamily: "assets/fonts/Cuprum.ttf")),
                                const Icon(Icons.chevron_right_outlined, size: 19, color: Colors.black,)]),
                          ),
                          Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 60,
                                  minHeight: 60,
                                  maxWidth: 360,
                                  maxHeight: heightListCluster,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: ResultClusterList(period: 7,),
                                ),
                              )
                          )
                        ]),
                        Column(children: [
                          Stack(children: [Container(
                              padding: const EdgeInsets.only(top:2,left: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset("assets/images/procent_icon.png"),
                                  Image.asset("assets/images/share_icon.png"),
                                ],
                              )
                          ),
                            SizedBox(height: heightPieTop,
                              child:MyRadarCharts(period: 30,),
                            ),
                            Container(margin: const EdgeInsets.only(top: 120),
                              child:Row(
                                // verticalDirection: VerticalDirection.down,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {},),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () {},),]) ,
                            ),
                          ]),
                          Container(margin:EdgeInsets.only(top: heightKalendTop),child:Row( mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(Icons.chevron_left_outlined, size: 19, color: Colors.black),
                                Text(
                                    DateTime.now().subtract(const Duration(days: 30)).add(const Duration(hours: 7)).day.toString()+" "+
                                        retMonth(DateTime.now().subtract(const Duration(days: 30)).add(const Duration(hours: 7)).month)+
                                        "---"+
                                        DateTime.now().add(const Duration(hours: 7)).day.toString()+" "+
                                        retMonth(DateTime.now().add(const Duration(hours: 7)).month),style: const TextStyle(fontSize: 19,fontWeight:FontWeight.w400,fontFamily: "fonts/Cuprum.ttf")),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {},
                                )
                              ]),
                          ),
                          Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 60,
                                  minHeight: 60,
                                  maxWidth: 360,
                                  maxHeight: heightListCluster,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: ResultClusterList(period: 30,),
                                ),
                              )
                          )
                        ]),
                        Column(children: [
                          Stack(children: [Container(
                              padding: const EdgeInsets.only(top:2,left: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset("assets/images/procent_icon.png"),
                                  Image.asset("assets/images/share_icon.png"),
                                ],
                              )
                          ),
                            SizedBox(height: heightPieTop,
                              child:MyRadarCharts(period: 360,),
                            ),
                            Container(margin: const EdgeInsets.only(top: 120),
                                child:Row(
                                  // verticalDirection: VerticalDirection.down,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back),
                                        onPressed: () {},),
                                      IconButton(
                                        icon: const Icon(Icons.arrow_forward),
                                        onPressed: () {},
                                      )
                                    ]
                                )
                            )
                          ]),
                          Container(
                            margin:EdgeInsets.only(top: heightKalendTop),
                            child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {},
                                  ),
                                  Text(
                                      " ${DateTime.now().year.toString()} год ",style: const TextStyle(fontSize: 19,fontWeight:FontWeight.w400,fontFamily: "assets/fonts/Cuprum.ttf")),
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward),
                                    onPressed: () {},
                                  )
                                ]
                            ),
                          ),
                          Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 60,
                                  minHeight: 60,
                                  maxWidth: 360,
                                  maxHeight: heightListCluster,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: ResultClusterList(period: 365,),
                                ),
                              )
                          )
                        ]),
                      ],
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}
class MyBalance extends StatelessWidget {
  const MyBalance({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightTabBar4=0;
    double heightPieTop=270;
    double heightKalendTop=35;
    double heightListCluster=187;
    if (width<370)
    {
      heightTabBar4=35;
      heightPieTop=220;
      heightKalendTop=20;
    }
    if (height>640)
    {
      heightTabBar4=0;
      heightPieTop=250;
      heightKalendTop=50;
      heightListCluster=213;
    }

    return Scaffold(
        body: Center(
          child:Stack(
            children: <Widget>[
              DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    floatingActionButton: Center(
                        child:Container(width: 280,margin: EdgeInsets.only(left: 30,top: heightTabBar4),height: 26,
                            child: TabBar(
                                labelPadding: const EdgeInsets.all(0),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.blueAccent,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.47),
                                  color: const Color(0xFF0077EF),
                                ),
                                tabs : [
                                  Tab(
                                      child:OverflowBox(
                                          minWidth: 0.0,
                                          maxWidth: 55.0,
                                          minHeight: 0.0,
                                          maxHeight: 24.0,
                                          child:Container(
                                            margin: const EdgeInsets.only(left: 5 ,top: 0.0,bottom: 0.0,right: 2.5),
                                            height: 24,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2.47),
                                              border: const Border(
                                                  top: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                                  left: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                                  right: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                                  bottom: BorderSide(width: 1.0, color: Color(0xFF0077EF))),
                                            ),
                                            child: const Text( "День",style: TextStyle(fontSize: 16.33,fontFamily: "assets/fonts/Cuprum.ttf",letterSpacing: 0)),
                                          )
                                      )
                                  ),
                                  Tab(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 2.5,right: 2.5 ),
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2.47),
                                        border: const Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            left: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            right: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFF0077EF))),
                                      ),
                                      child: const Text( "Неделя",style: TextStyle(fontSize: 16.33,fontFamily: "assets/fonts/Cuprum.ttf",letterSpacing: 0)),
                                    ),
                                  ),
                                  Tab( child:
                                  Container(
                                    margin: const EdgeInsets.only(left: 2.5,right: 2.5,top: 0 ),
                                    height: 24,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.47),
                                      border: const Border(
                                          top: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                          left: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                          right: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                          bottom: BorderSide(width: 1.0, color: Color(0xFF0077EF))),
                                    ),
                                    child: const Text( "Месяц",style: TextStyle(fontSize: 16.33,fontFamily: "assets/fonts/Cuprum.ttf",letterSpacing: 0)),
                                  ),
                                  ),
                                  Tab(
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.only(left: 2.5,right: 2.5 ),
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2.47),
                                        border: const Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            left: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            right: BorderSide(width: 1.0, color: Color(0xFF0077EF)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFF0077EF))),
                                      ),
                                      child: const Text( "Год",style: TextStyle(fontSize: 16.33,fontFamily: "assets/fonts/Cuprum.ttf",letterSpacing: 0)),
                                    ),
                                  ),
                                ] /* End TabBar.tabs. */
                            )
                        )
                    ),
                    body: TabBarView(
                      children: [
                        Column(children: [
                          Stack(children: [Container(
                              padding: const EdgeInsets.only(top:2,left: 0,right: 0),
                              margin: const EdgeInsets.only(top: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset("assets/images/share_icon.png"),
                                ],
                              )
                          ),
                            SizedBox(height: heightPieTop,
                              child:KrugBalansaDay(period: 1,height: height,),
                            ),
                            Container(margin: const EdgeInsets.only(top: 120),
                              child:Row(
                                // verticalDirection: VerticalDirection.down,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      padding: const EdgeInsets.only(left: 40),
                                      icon: const Icon(Icons.arrow_back_ios,color: Color(0xFF0077EF)),
                                      onPressed: () {},),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward_ios,color: Color(0xFF0077EF),),
                                      padding: const EdgeInsets.only(right: 40),
                                      onPressed: () {},),]) ,),
                          ]),
                          Container(margin:EdgeInsets.only(top: heightKalendTop),child:Row( mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(Icons.arrow_back_ios, size: 19, color: Colors.black),
                                Text(
                                    DateTime.now().add(const Duration(hours: 7)).day.toString()+
                                        " "+retMonth(DateTime.now().add(const Duration(hours: 7)).month)+
                                        ", "+retDay(DateTime.now().add(const Duration(hours: 7)).weekday),style: const TextStyle(fontSize: 18,fontWeight:FontWeight.w600,fontFamily: "fonts/Cuprum.ttf")),
                                const Icon(Icons.arrow_forward_ios, size: 19, color: Colors.black,)]),
                          ),
                          Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 60,
                                  minHeight: 60,
                                  maxWidth: 360,
                                  maxHeight: heightListCluster,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: const ClusterList2(period: 1,),
                                ),
                              )
                          )
                        ]),
                        Column(children: [
                          Stack(children: [
                            Container(
                                padding: const EdgeInsets.only(top:2,left: 15,right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.asset("assets/images/procent_icon.png"),
                                    Image.asset("assets/images/share_icon.png"),
                                  ],
                                )
                            ),
                            SizedBox(height: heightPieTop,
                              child:KrugBalansaDay(period: 7,height: height),
                            ),
                            Container(margin: const EdgeInsets.only(top: 120),
                              child:Row(
                                // verticalDirection: VerticalDirection.down,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {},),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () {},),]) ,),
                          ]),
                          Container(margin:EdgeInsets.only(top: heightKalendTop),child:Row( mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(Icons.chevron_left_outlined, size: 19, color: Colors.black),
                                Text(
                                    DateTime.now().add(const Duration(hours: 7)).day.toString()+
                                        " "+retMonth(DateTime.now().add(const Duration(hours: 7)).month)+
                                        ", "+retDay(DateTime.now().add(const Duration(hours: 7)).weekday),style: const TextStyle(fontSize: 19,fontWeight:FontWeight.w400,fontFamily: "fonts/Cuprum.ttf")),
                                const Icon(Icons.chevron_right_outlined, size: 19, color: Colors.black,)]),
                          ),
                          Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 60,
                                  minHeight: 60,
                                  maxWidth: 360,
                                  maxHeight: heightListCluster,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: const ClusterList2(period: 7,),
                                ),
                              )
                          )
                        ]),
                        Column(children: [
                          Stack(children: [Container(
                              padding: const EdgeInsets.only(top:2,left: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset("assets/images/procent_icon.png"),
                                  Image.asset("assets/images/share_icon.png"),
                                ],
                              )
                          ),
                            SizedBox(height: heightPieTop,
                              child:KrugBalansaDay(period: 30,height: height),
                            ),
                            Container(margin: const EdgeInsets.only(top: 120),
                              child:Row(
                                // verticalDirection: VerticalDirection.down,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {},),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () {},),]) ,),
                          ]),
                          Container(margin:EdgeInsets.only(top: heightKalendTop),child:Row( mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(Icons.chevron_left_outlined, size: 19, color: Colors.black),
                                Text(
                                    DateTime.now().add(const Duration(hours: 7)).day.toString()+
                                        " "+retMonth(DateTime.now().add(const Duration(hours: 7)).month)+
                                        ", "+retDay(DateTime.now().add(const Duration(hours: 7)).weekday),style: const TextStyle(fontSize: 19,fontWeight:FontWeight.w400,fontFamily: "fonts/Cuprum.ttf")),
                                const Icon(Icons.chevron_right_outlined, size: 19, color: Colors.black,)]),
                          ),
                          Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 60,
                                  minHeight: 60,
                                  maxWidth: 360,
                                  maxHeight: heightListCluster,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: const ClusterList2(period: 30.41666667
                                    ,),
                                ),
                              )
                          )
                        ]),
                        Column(children: [
                          Stack(children: [Container(
                              padding: const EdgeInsets.only(top:2,left: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset("assets/images/procent_icon.png"),
                                  Image.asset("assets/images/share_icon.png"),
                                ],
                              )
                          ),
                            SizedBox(height: heightPieTop,
                              child:KrugBalansaDay(period: 365,height: height),
                            ),
                            Container(margin: const EdgeInsets.only(top: 120),
                              child:Row(
                                // verticalDirection: VerticalDirection.down,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {},),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () {},),]) ,),
                          ]),
                          Container(margin:EdgeInsets.only(top: heightKalendTop),child:Row( mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(Icons.chevron_left_outlined, size: 19, color: Colors.black),
                                Text(
                                    DateTime.now().add(const Duration(hours: 7)).day.toString()+
                                        " "+retMonth(DateTime.now().add(const Duration(hours: 7)).month)+
                                        ", "+retDay(DateTime.now().add(const Duration(hours: 7)).weekday),style: const TextStyle(fontSize: 19,fontWeight:FontWeight.w400,fontFamily: "fonts/Cuprum.ttf")),
                                const Icon(Icons.chevron_right_outlined, size: 19, color: Colors.black,)]),
                          ),
                          Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 60,
                                  minHeight: 60,
                                  maxWidth: 360,
                                  maxHeight: heightListCluster,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 0),
                                  child: const ClusterList2(period: 365.25,),
                                ),
                              )
                          )
                        ]),
                      ],
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}
class MyProfile extends StatelessWidget{
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Text( FirebaseAuth.instance.currentUser!.email.toString()),
      ),
      const Text("Мой профиль")
    ],
    );
  }
}
class MyStat extends StatelessWidget{
  const MyStat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: DefaultTabController(
            length : 2,
            child :Scaffold(
              body : TabBarView(
                  children : [
                    HomePage(),
                    Text("Моя статистика")
                  ] /* End TabBarView.children. */
              ),
            )
        )

    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _pageCount = 2;
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _body() {
    return Stack(
      children: List<Widget>.generate(_pageCount, (int index) {
        return IgnorePointer(
          ignoring: index != _pageIndex,
          child: Opacity(
            opacity: _pageIndex == index ? 1.0 : 0.0,
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (_) => _page(index),
                  settings: settings,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _page(int index) {
    switch (index) {
      case 0:
        return MyCalendarPage();
      case 1:
        return const Page2();
    }

    throw "Invalid index $index";
  }

  BottomNavigationBar _bottomNavigationBar() {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      fixedColor: theme.colorScheme.secondary,
      currentIndex: _pageIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "Page 1",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Page 2",
        ),
      ],
      onTap: (int index) {
        setState(() {
          _pageIndex = index;
        });
      },
    );
  }
}
class MyLife extends StatefulWidget {
  const MyLife({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyLife();
}
class _MyLife extends State<MyLife>{
  Color? selectedColor = Colors.lightGreen[300];
  final Notifications _notifications =  Notifications();

  @override
  void initState() {
    super.initState();
    _notifications.initNotifications();
  }

  void _pushNotification() {
    _notifications.pushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (var states) => selectedColor!,
                  )),
              child: const Text(
                'Change the color of the button',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OColorPicker(
                        selectedColor: selectedColor,
                        colors: primaryColorsPalette,
                        onColorChange: (color) {
                          setState(() {
                            selectedColor = color;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushNotification,
        tooltip: 'Push notifications',
        child: const Icon(Icons.add),
      ),
    );
  }
}
retDay(int day){
  switch(day){
    case 1:
      return "Понедельник";
    case 2:
      return "Вторник";
    case 3:
      return "Среда";
    case 4:
      return "Четверг";
    case 5:
      return "Пятница";
    case 6:
      return "Суббота";
    case 7:
      return "Воскресенье";
    default:
      // print('Неверный номер дня недели!');

  }
}
retMonth(int month){
  switch(month){
    case 1:
      return "Января";
    case 2:
      return "Февраля";
    case 3:
      return "Марта";
    case 4:
      return "Апреля";
    case 5:
      return "Мая";
    case 6:
      return "Июня";
    case 7:
      return "Июля";
    case 8:
      return "Августа";
    case 9:
      return "Сентября";
    case 10:
      return "Октября";
    case 11:
      return "Ноября";
    case 12:
      return "Декабря";
    default:
      // print('Неверный номер месяца!');

  }
}
class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Page2();
}
class _Page2 extends State<Page2> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  Color? selectedColor = const Color(0xFFFF9324);
  String? _name;
  String? _color;
  @override
  Widget build(BuildContext context) {
    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
          decoration: InputDecoration(
              hintStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blueAccent),
              hintText: hint,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 3)
              ),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1)
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                    data: const IconThemeData(color: Colors.white),
                    child: icon
                ),
              )
          ),
        ),
      );
    }
    Widget _button(String text, void Function() func){
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          onPrimary: Colors.white,
          shadowColor: Colors.greenAccent,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0)),
          minimumSize: const Size(100, 40), //////// HERE
        ),
        child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 20)
        ),
        onPressed: (){
          func();
        },


      );
    }
    void _writeClusterButtonAction() async{
      _name = _nameController.text;
      _color = _colorController.text;


    }
    Widget _form(String label, void Function() func){

      return Column(
        children:<Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _input(const Icon(Icons.drive_file_rename_outline), "Имя",_nameController,false)
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (var states) => selectedColor!,
                    )),
                child: const Text(
                  'Выбири цвет для кластера',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OColorPicker(
                          selectedColor: selectedColor,
                          colors: primaryColorsPalette,
                          onColorChange: (color) {
                            setState(() {
                              selectedColor = color;
                              // print("$selectedColor");
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label,func),
            ),
          )
        ],
      );
    }
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(
                    child: _form("Добавить кластер", _writeClusterButtonAction),
                  )
                ]
            )
        )
    );
  }
}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(_, TextEditingValue nv) =>
      TextEditingValue(text: nv.text.toUpperCase(), selection: nv.selection);
}
