
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fractal/feature/data/database.dart';


class TaskListResult extends StatefulWidget {
  const TaskListResult({Key? key, required this.title,required this.clusterKey, required this.color}) : super(key: key);
  final String title;
  final String clusterKey;
  final String color;
  @override
  _TaskListResultState createState() => _TaskListResultState();
}
class _TaskListResultState extends State<TaskListResult> {
  Query? _query;
  List<TextEditingController> listControl=[];
  FixedExtentScrollController fixedExtentScrollController =
  FixedExtentScrollController();
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 25);
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }
  @override
  void initState() {
    Database.queryTasks(widget.clusterKey).then((Query query) {
      setState(() {
        _query = query;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthTextRow=160;
    if(width<361){
      widthTextRow=110;
    }
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
            Row(children: const [],)
          ],),
        )
      ],
    );
    if (_query != null) {
      Map<String, TextEditingController> _controllerMap = {};


      TextEditingController _getControllerOf( String name,int time) {
        var controller = _controllerMap[name];

        if (controller == null) {
          // print("КОНТРОЛЕР: ${controller}");
          controller = TextEditingController(text: time.toString());
          _controllerMap[name] = controller;
          // print("КОНТРОЛЕР: ${_controllerMap.values.first}");
        }
        return controller;
      }


      body = FirebaseAnimatedList(
        query: _query!,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index,
            )
        {

          String? taskKey = snapshot.key;
          // Map map = snapshot.value;
          Map map = {};
          // String taskName = map['name'] as String;
          // int timeTask = map['timeTask'] as int;
          // bool compl = map['completed'] as bool;
          String taskName = map['name'] as String;
          int timeTask = map['timeTask'] as int;
          bool compl = map['completed'] as bool;

          FixedExtentScrollController fixedExtentScrollControllerHour = FixedExtentScrollController();
          FixedExtentScrollController fixedExtentScrollControllerMin = FixedExtentScrollController();
          List _hour = List<int>.generate(25, (int index) => index);
          List _min = List<int>.generate(61, (int index) => index);
          return Column(
            children: <Widget>[
              CheckboxListTile(
                value:compl,
                shape: const CircleBorder(),
                enableFeedback:true,
                // controlAffinity: ListTileControlAffinity.values.last,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [compl?const Icon(
                                  Icons.check_circle,size: 25, color: Colors.green,):const Icon(
                                  Icons.check_circle_outline,size: 25, color: Colors.green),
                                SizedBox(width: widthTextRow,
                                    child: Text('${map['name']}',
                                        style: TextStyle(decoration:compl?TextDecoration.lineThrough:TextDecoration.none,
                                            color: const Color.fromRGBO(
                                                109, 109, 109, 1.0) ,
                                            letterSpacing: 0,
                                            fontSize: 19.8,
                                            height: 1,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "fonts/Cuprum.ttf"))
                                ),
                              ]
                          )
                             ,
                          IconButton (
                            icon: const Icon(Icons.keyboard_arrow_up,color: Color(0xFF707070),size: 40,),
                            onPressed: () {
                              _selectTime();
                            }
                          ),
                          Stack(children: [
                            SizedBox(width:40,height: 30,
                                child: TextField(
                                  controller:_getControllerOf(taskName,timeTask),
                                  onTap: () async {
                                    // print(" widget key ####### ${widget.createState()}");
                                    await showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Укажите время выполнения'),
                                          content: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                            Container(
                                              alignment: const Alignment(10, 10),
                                              width:60,
                                              height:40,
                                              child: ListWheelScrollView(
                                                  diameterRatio: 1,
                                                  controller: fixedExtentScrollControllerHour,
                                                  physics: const FixedExtentScrollPhysics(),

                                                  children: _hour.map((hours) {
                                                    return Card(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child:Text(
                                                                      "$hours",textAlign: TextAlign.center,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600)
                                                                  ),
                                                                )),
                                                          ],
                                                        ));
                                                  }).toList(),
                                                  itemExtent: 50.0,
                                                ),
                                      )  ,
                                        const Text(" : "),
                                        SizedBox(
                                          width:60,
                                          height: 40,
                                          child:ListWheelScrollView(
                                                  controller: fixedExtentScrollControllerMin,
                                                  physics: const FixedExtentScrollPhysics(),
                                                  children: _min.map((min) {
                                                    return Card(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(1.0),
                                                                  child:Text(
                                                                      "$min",textAlign: TextAlign.center,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                                                  ),

                                                                )),
                                                          ],
                                                        ));
                                                  }).toList(),
                                                  itemExtent: 40.0,
                                                ) ,
                                      ),
                                      ]),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // print("selectedItem: ${fixedExtentScrollControllerHour}");
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );}),),

                          ],),



                          IconButton (
                              icon: const Icon(Icons.keyboard_arrow_down,color: Color(0xFF707070),size: 40,),
                              onPressed: () {
                                _selectTime();
                              }
                          ),
                          const SizedBox(height:3),
                        ],
                      ),
                    ]) ,
                onChanged: (val) {
                  Feedback.forTap(context);
                  setState(() {
                    if(!map['completed']){
                      // print("_controllerMap: ${_controllerMap.values.toList()}");
                      // print("  index : $index");
                      // print("  _controllerMap.values.length : ${_controllerMap.values.length}");
                      // print("  _controllerMap.values.length : ${_controllerMap.values}");

                      Database.createComplTask(widget.clusterKey,taskKey,map["name"],widget.title,_controllerMap.values.elementAt(index).text,widget.color);
                      // print("compl: $val");

                    }

                    map['completed'] = !map['completed'];
                    Database.saveTaskCompl(widget.clusterKey,taskKey!,map['completed']);
                    // _value=map['completed'];
                    // print("map.values.toString()###### ${map.values.toString()}");
                   // toggle the completion
                  });
                },
              ),
              const Divider(
                color: Color(0x8D535353),
                height: 1.0,
                thickness: 2.0,
              ),
            ],
          );
        },
      );
// body=_futureBuilder();

    }
    return Scaffold(
      appBar: AppBar(centerTitle:true,
        iconTheme: const IconThemeData(
          size: 40,
          color: Colors.black, //change your color here
        ),
        backgroundColor: const Color(0x00000000),
        elevation: 0,
        title : Text(widget.title,style: const TextStyle(
            color: Color(0xff000000),
            fontFamily: "fonts/Cuprum.ttf",
            fontSize: 27.57,
            letterSpacing: 0,
            fontWeight: FontWeight.w600,
            height: 1.27
        )
        ),),
      body: body,
    );
  }
}
class Task {
  int completedTimeTask;
  String name;
  bool completed;

  Task({
    required this.completedTimeTask,
    required this.name,
    required this.completed,
  });
}