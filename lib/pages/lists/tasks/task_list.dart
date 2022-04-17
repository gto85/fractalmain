import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


import '../../../data/database.dart';
import '../../../screens/tasks/edit_list.dart';


class TaskList extends StatefulWidget {
  const TaskList({Key? key, required this.title,required this.clusterKey, required this.color}) : super(key: key);
  final String title;
  final String clusterKey;
  final String color;
  @override
  _TaskList1State createState() => _TaskList1State();
}
class _TaskList1State extends State<TaskList> {
  Query? _query;
  @override
  void initState() {
    // TODO:
    super.initState();
    Database.queryTasks(widget.clusterKey).then((Query query) {
      setState(() {
        _query = query;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    Widget body = ListView(
      children: const <Widget>[
        ListTile(
          title: Text("Задачи отсутствуют..."),
        )
      ],
    );
    if (_query != null) {
      body = FirebaseAnimatedList(
        query: _query!,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index,
            ) {
          String? taskKey = snapshot.key;
          // Map map = snapshot.value;
          String taskName = ['name'] as String;
          int timeTask = ['timeTask'] as int;
          // String taskName = map['name'] as String;
          // int timeTask = map['timeTask'] as int;

          return Column(
            children: <Widget>[
              ListTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        margin:const EdgeInsets.only(right: 16),
                        child: Icon(Icons.brightness_1_rounded,color: Color(int.parse(widget.color)),size: 35,)
                      ),
                      SizedBox(width: 110,child: Text(
                              taskName,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  wordSpacing: 1,
                                  color: Color.fromRGBO(1, 1, 1, 1.0) ,
                                  letterSpacing: 0,
                                  fontSize: 19.8,
                                  height: 1,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "fonts/Cuprum.ttf"))
                      ),
                      SizedBox(
                        width: 108,
                        child: Text('  ${timeTask~/60.round()} ч. ${timeTask%60} мин.',
                            style: const TextStyle(
                                color: Color.fromRGBO(1, 1, 1, 1.0) ,
                                letterSpacing: 0,
                                fontSize: 16.8,
                                height: 1,
                                fontWeight: FontWeight.w800,
                                fontFamily: "fonts/Cuprum.ttf")),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 0),
                          child: IconButton (
                          icon: Image.asset("images/_edit_icon.png",width: 20,height: 15),
                          iconSize: 20,
                          onPressed: () {
                          _editTask(taskKey!,widget.clusterKey);

                          }))
                    ]) ,
              ),
              const Divider(
              color: Color(0x8D535353),
              height: 3.0,
              thickness: 1.0,
              )
              ,
            ],
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        iconTheme: const IconThemeData(color: Color(0xff404040), opacity: 1, size: 35),

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
      floatingActionButton: FloatingActionButton(
        child: Image.asset("images/task-planning.png",width: 45,height: 45),
        onPressed: () {
          String taskKey = widget.clusterKey;
          showDialog<Map>(
            context: context,
            builder: (context) {
              final _textController = TextEditingController();
              final _timeController = TextEditingController();

              return AlertDialog(
                title: const Text('Добавление новых задач'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Добавить новую задачу"),
                    TextField(
                      controller: _textController,
                      decoration:
                      const InputDecoration(labelText: 'Название новой задачи'),
                    ),
                    TextField(
                      controller: _timeController,
                      decoration:
                      const InputDecoration(labelText: 'Время новой задачи'),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          _createTasks(taskKey,_textController.text,_timeController.text);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Добавить задачу"))
                  ],
                ),
              );
            },
          ).then((value) {
            setState(() {
              if (value != null) {
                _createTasks(taskKey,"empty","0");
              }
            });
          });
        },
      ),
    );
  }

  void _createTasks(String key,String name,String time) {
    Database.createTasks(key,name,time);

  }
  void _editTask(String listKey,String clusterKey) {
    var route = MaterialPageRoute(
      builder: (context) => EditListPage(listKey: listKey,clustKey:clusterKey),
    );
    Navigator.of(context).push(route);
  }
}
