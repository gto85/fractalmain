
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fractal/data/database.dart';
import 'package:fractal/models/char_needs.dart';
import 'package:fractal/repositories/createDataCharts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KrugBalansaDay extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  KrugBalansaDay({Key? key, required this.period,required this.height}) : super(key: key);

  late double period;
  late double height;

  @override

  _KrugBalansaDayState createState() => _KrugBalansaDayState();
}
class _KrugBalansaDayState extends State<KrugBalansaDay> {
  late List<CharNeed> _charData;
  Query? _query;
  num test=0;
  late double period=widget.period;
  late double height=widget.height;
  CircularSeriesController? seriesController;
  @override
  void initState() {
    _charData=  getChartData()!;
    Database.TimeClusters().then((value) {
      value.once().then((value) {
        Map<dynamic, dynamic> _myMap ;
        // _myMap=value.snapshot.value;
        test=0;
        // _myMap.forEach((key, value) {
        //   test=test+value["timeCluster"];
        //   // print("TEST0: $test");
        // });
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
    // print("TEST: ${test.toStringAsFixed(2)}");
    double heigh=150;
    String percInerRad="70%";
    double height = MediaQuery.of(context).size.height;

    if (heigh<641)
    {
      heigh=150;
    }
    if (height>640)
    {
      heigh=175;
    }
    // print("высота: $height ширина: $width");
    return
      SfCircularChart(
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: const Border(
                        top: BorderSide(width: 3.0, color: Color(0xFFFFFFFF)),
                        left: BorderSide(width: 3.0, color: Color(0xFFFFFFFF)),
                        right: BorderSide(width: 3.0, color: Color(0xFFFFFFFF)),
                        bottom: BorderSide(width: 3.0, color: Color(0xFFFFFFFF))),
                  ),
                  child: PhysicalModel(
                      child: SizedBox(width: heigh,
                      height: heigh,),
                      shape: BoxShape.circle,
                      elevation: 0,
                      shadowColor: Colors.white,
                      color: const Color(0xFF000000)))),
          CircularChartAnnotation(
              widget: Text("${test*period~/60.round()} ч.\n ${test*period%60} мин.",textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: "fonts/Cuprum.ttf",letterSpacing: 0, fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(
                          255, 255, 255, 1), fontSize: 35)))
        ],
        series: <CircularSeries>[
        DoughnutSeries<CharNeed, String>(
          onRendererCreated: (CircularSeriesController  controller) {
            seriesController = controller;
          },
          innerRadius: percInerRad,
          explode: false,
          explodeIndex: 2,
          onPointLongPress: (ChartPointDetails details) {
          },
          onPointTap: (ChartPointDetails details) {
          },
          onPointDoubleTap:(ChartPointDetails details) {
            // print("Данные чарта:${details.dataPoints}Номер чарта:${details.pointIndex}series чарта:${details.seriesIndex}viewportPointIndex чарта:${details.viewportPointIndex}");
            },
          strokeWidth:4.0,
          dataSource: _charData,
          xValueMapper: (CharNeed data, _)=>data.name,
          pointColorMapper:(CharNeed data,  _) => data.color,
          yValueMapper: (CharNeed data, _)=>data.value*24/100,
          // dataLabelSettings: DataLabelSettings(isVisible: false, labelAlignment: ChartDataLabelAlignment.bottom, labelPosition: ChartDataLabelPosition.inside),
          strokeColor: const Color(0xFFFFFFFF),
          radius:"100%",
          selectionBehavior: SelectionBehavior(selectedColor: Colors.red,unselectedColor: Colors.grey),
        )
      ],);
  }
  List<CharNeed>? getChartData(){
    List<CharNeed>? charData=[];
    printFileContent(charData);
    // print("CHARDATA${charData}");
    return charData;
  }
}



