import 'dart:async';
import 'dart:math' as math;
import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fractal/feature/balance_plan/balance_screen_plan_day.dart';
import 'package:fractal/feature/balance_plan/createDataCharts.dart';
import 'package:fractal/feature/data/database.dart';



class MyRadarCharts extends StatefulWidget {
  final int period;
  MyRadarCharts({Key? key, required this.period }) : super(key: key);
  @override
  _CharTestState createState() => _CharTestState();
}
Future<List<CharNeedResult>?> getDataChList(int period) async {
  List<CharNeed>? planResult= await Database.getCharNeeds();
  List<CharNeed>? tempResult= await Database.getResultCharNeeds(period);
  // List<CharNeed>? weekResult= await Database.getResultCharNeedsWeek(period);
  List<CharNeedResult>? result= [];
  double sum=0;
  double plan=0;
  // print(weekResult);
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
class _CharTestState extends State<MyRadarCharts> {
   List<CharNeed> _charResData=[];
   List<CharNeed> _charPlanData=[];
   List<CharNeed> newListNeed=[];

   num test=0;
   Query? _query;
   // var _key = Key(DateTime.now().millisecondsSinceEpoch.toString());
   void pressButton() {
     setState(() {
       _charPlanData = getChartDataMin()!;
       _charResData = getChartData()!;
       // _key!=_key;
     });
   }
  @override
  void initState(){
    _charPlanData = getChartDataMin()!;
    _charResData = getChartData()!;
     super.initState();
  }
  @override
  Widget build(BuildContext context) {

    List l1=[];
    List l2=[];
    List l3=[];

    // print("DateTime.now().millisecondsSinceEpoch: ${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}");
    var newMap =_charResData.groupListsBy((element) => element.name);

    newMap.forEach((key, value){
      l1.add(key);
      l2.add(value.first.color);
      double tempsum=0;
      print("newMap.forEach: = = =  key: ${key} value: ${value}");
        for(var i=0; i<value.length;i++){
          tempsum=tempsum+value.elementAt(i).value;
        }
      // var newListNeed;
      newListNeed.add(CharNeed(tempsum, key, value.first.color));
      l3.add(tempsum);
      tempsum=0;
    });

    int row =  l3.length;
    int col = l3.length;
    var twoDList = List.generate(row, (i) => List.filled(col, 0.0, growable: true), growable: false);
    var mValMap=l3.asMap();
    print("PERIOD: ${context}");
    mValMap.forEach((key, value) {
      twoDList[key][key]=(value*100/_charPlanData[key].value)/widget.period;
      twoDList[key][key]=(value*100/_charPlanData[key].value)/widget.period;
    });
    for(var i=0; i<twoDList.length; i++){
       print("1111two list i: ${twoDList.elementAt(i)}");
      // [i==twoDList.length-1?0:i+1==twoDList.length?i+1:i-1]
      twoDList[i][i==twoDList.length-1?0:i+1==twoDList.length?i-1:i+1] = twoDList[i][i];
    }
    // print("dat$twoDList");
    l3=twoDList;
    // l3= [
    //   [100,100,0,0,0],
    //   [0,100,100,0,0],
    //   [0,0,100,100,0],
    //   [0,0,0,100,100]
    // ];
    return
      Container(
        child:
        CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: RadarChartPainter(l1,l2,l3),
          // foregroundPainter: MyPaintTop()
        ),
      );
  }
  List<CharNeed>? getChartData()  {
    List<CharNeed>? _charResData=[];
    poluch(_charResData,widget.period);
    print("_charResData${_charResData}");
    return _charResData;
  }
  List<CharNeed>? getChartDataMin()  {
     List<CharNeed>? _charPlanData=[];
     poluchMin(_charPlanData);
      print("_charPlanData${_charPlanData}");
     return _charPlanData;
   }
}
// class ArcText extends StatelessWidget {
//   const ArcText({
//     Key? key,
//     required this.radius,
//     required this.text,
//     required this.textStyle,
//     this.startAngle = 0,
//   }) : super(key: key);
//
//   final double radius;
//   final String text;
//   final double startAngle;
//   final TextStyle textStyle;
//
//   @override
//   Widget build(BuildContext context) => CustomPaint(
//     painter: _Painter(
//       radius,
//       text,
//       textStyle,
//       initialAngle: startAngle,
//     ),
//     willChange: true,
//   );
// }
// class _Painter extends CustomPainter {
//   _Painter(this.radius, this.text, this.textStyle, {this.initialAngle = 0});
//
//   final num radius;
//   final String text;
//   final double initialAngle;
//   final TextStyle textStyle;
//
//   final _textPainter = TextPainter(textDirection: TextDirection.ltr);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.translate(size.width / 2, size.height / 2 - radius);
//
//     if (initialAngle != 0) {
//       final d = 2 * radius * math.sin(initialAngle / 2);
//       final rotationAngle = _calculateRotationAngle(0, initialAngle);
//       canvas.rotate(rotationAngle);
//       canvas.translate(d, 0);
//     }
//
//     double angle = initialAngle;
//     for (int i = 0; i < text.length; i++) {
//       angle = _drawLetter(canvas, text[i], angle);
//     }
//   }
//
//   double _drawLetter(Canvas canvas, String letter, double prevAngle) {
//     _textPainter.text = TextSpan(text: letter, style: textStyle);
//     _textPainter.layout(
//       minWidth: 0,
//       maxWidth: double.maxFinite,
//     );
//
//     final double d = _textPainter.width;
//     final double alpha = 2 * math.asin(d / (2 * radius));
//
//     final newAngle = _calculateRotationAngle(prevAngle, alpha);
//     canvas.rotate(newAngle);
//
//     _textPainter.paint(canvas, Offset(0, -_textPainter.height));
//     canvas.translate(d, 0);
//
//     return alpha;
//   }
//
//   double _calculateRotationAngle(double prevAngle, double alpha) =>
//       (alpha + prevAngle) / 2;
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
class RadarChartPainter extends CustomPainter {
  List list1;List list2;List list3;
  RadarChartPainter(this.list1,this.list2,this.list3);

  @override
  void paint(Canvas canvas, Size size) {

    // canvas.save();

    // rotate the canvas
    // final degrees = 15;
    // final radians = degrees * pi / 180;
    // canvas.rotate(radians);


    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var centerOffset = Offset(centerX, centerY);
    var radius = centerX * 0.5;

    var outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;

    canvas.drawCircle(centerOffset, radius, outlinePaint);
    var ticks = [10, 20, 30,40,50,60,70,80,90,100];
    var tickDistance = radius / (ticks.length);
    const double tickLabelFontSize = 9;

    var ticksPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..isAntiAlias = true;

    ticks.sublist(0, ticks.length - 1).asMap().forEach((index, tick) {
      var tickRadius = tickDistance * (index + 1);

      canvas.drawCircle(centerOffset, tickRadius, ticksPaint);

      TextPainter(
        text: TextSpan(
          text: tick.toString(),
          style: TextStyle(color: Colors.black, fontSize: tickLabelFontSize),
        ),
        textDirection: TextDirection.rtl,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(
            canvas, Offset(centerX, centerY - tickRadius - tickLabelFontSize));
    });

    // var features = ["Навыки","Душа","Тело","Деньги","Семья","Социум","Родственики"];

    var features=list1;
    var angle = (2 * math.pi) / features.length;
    const double featureLabelFontSize = 13;
    const double featureLabelFontWidth = 10;

    features.asMap().forEach((index, feature) {
      var xAngle = math.cos(angle * index - math.pi / 2);
      var yAngle = math.sin(angle * index - math.pi / 2);


      var featureOffset =
      Offset(centerX + radius * xAngle, centerY + radius * yAngle);

      // canvas.drawLine(centerOffset, featureOffset, ticksPaint);

      var labelYOffset = yAngle < 0 ? -featureLabelFontSize : 0;
      var labelXOffset = xAngle < 0 ? -featureLabelFontWidth * feature.length : 0;

      TextPainter(
        text: TextSpan(
          text:feature,
          style: TextStyle(color: Colors.black, fontSize: featureLabelFontSize),
        ),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(
            canvas,
            Offset(featureOffset.dx + labelXOffset,
                featureOffset.dy + labelYOffset));
    });

    var graphColors = list2;
    var scale = radius / ticks.last;
    var data=list3;

    data.asMap().forEach((index, graph) {
      var graphPaint = Paint()
        ..color = graphColors[index % graphColors.length].withOpacity(0.7)
        ..style = PaintingStyle.fill;

      var graphOutlinePaint = Paint()
        ..color = graphColors[index % graphColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.0
        ..isAntiAlias = true;
      var scaledPoint = scale * graph[0];
      var path = Path();
      path.moveTo(centerX, centerY - scaledPoint);
      graph.sublist(1).asMap().forEach((index, point) {
        var xAngle = math.cos(angle * (index + 1) - math.pi / 2);
        var yAngle = math.sin(angle * (index + 1) - math.pi / 2);
        var scaledPoint = scale * point;
        path.lineTo(
            centerX + scaledPoint * xAngle, centerY + scaledPoint * yAngle);
      });
      path.close();
      // pathRound.close();
      canvas.drawPath(path, graphPaint);
      // canvas.drawPath(pathRound, graphPaint);
      canvas.drawPath(path, graphOutlinePaint);
    });
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}


