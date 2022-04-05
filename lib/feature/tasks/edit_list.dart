import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fractal/feature/data/database.dart';
import 'edit_task.dart';

class EditListPage extends StatefulWidget {
  static String routeName = '/edit_list';
  final String listKey;
  final String clustKey;
  const EditListPage({Key? key, required this.listKey, required this.clustKey}) : super(key: key);
  @override
  _EditListPageState createState() => _EditListPageState();
}
class _EditListPageState extends State<EditListPage> {
  final _nameFieldTextController = TextEditingController();
  final _timeFieldTextController = TextEditingController();
  StreamSubscription? _subscriptionName;
  StreamSubscription? _subscriptionTime;

  @override
  void initState() {
    _nameFieldTextController.clear();
    _timeFieldTextController.clear();
    Database.getNameStream(widget.listKey, _updateName)
        .then((StreamSubscription s) => _subscriptionName = s).then((StreamSubscription t) => _subscriptionTime=t);
    super.initState();
  }
  @override
  void dispose() {
    if (_subscriptionName != null && _subscriptionTime != null) {
      _subscriptionName!.cancel();
      _subscriptionTime!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  const Text("Редактирование задачи"),
      ),
      body:  ListView(
        children: <Widget>[
           ListTile(
            title: TextField(
              controller: _nameFieldTextController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.edit),
                  labelText: "Имя задачи",
                  hintText: "Введите имя задачи..."
              ),
              onChanged: (String value) {
                Database.saveTask(widget.clustKey, widget.listKey,value);
              },
            ),

          ),
          ListTile(
            title: TextField(
              controller: _timeFieldTextController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.edit),
                  labelText: "Время задачи",
                  hintText: "Введите время задачи..."
              ),
              onChanged: (String value) {
                num tempVal=0;
                Database.saveTaskTime(widget.clustKey, widget.listKey,int.parse(value));
                Database.queryTasks(widget.clustKey).then((value) {
                  value.once().then((value) {
                    Map<dynamic, dynamic> _myMap ;
                    print(value.snapshot.value);

                    // _myMap.forEach((key, value) {
                    //   tempVal=tempVal+value["timeTask"];
                    // });
                    Database.setClusterTime(widget.clustKey, tempVal.toInt());
                  });
                });
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (var states) => const Color(0xff8c0000),
                      )),
                  child: const Text(
                    'Удалить задачу',
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  onPressed: (){
                    Database.delClusterTask(widget.clustKey,widget.listKey);
                      var route = MaterialPageRoute(
                      builder: (context) => EditTaskPage(taskKey: widget.clustKey,nameCluster: "Nnnn",color: "",),
                      );
                      Navigator.of(context).push(route);
                      }

              )
          ),
        ],
      ),
    );
  }

  void _updateName(String name) {
    _nameFieldTextController.value = _nameFieldTextController.value.copyWith(
      text: name,
    );
  }
}