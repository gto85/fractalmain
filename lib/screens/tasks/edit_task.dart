import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fractal/services/auth.dart';


import '../../data/database.dart';
import '../../pages/lists/tasks/task_list.dart';
import '../../pages/lists/complete/tasklist_result.dart';

class EditTaskPage extends StatefulWidget {
  static String routeName = '/edit_task';
  final String taskKey;
  final String nameCluster;
  final String color;


  EditTaskPage({Key? key, required this.taskKey, required this.nameCluster, required this.color}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _nameFieldTextController = TextEditingController();
  final String iduser = FirebaseAuth.instance.currentUser!.uid;
  final fb = FirebaseDatabase.instance;
  String result =  FirebaseDatabase.instance.reference().child("path/to/user/record/email").once().toString();

  // final DatabaseReference taskRef =
  // FirebaseDatabase.instance.reference().child("accounts").child(iduser).child("Clusters").child(taskKey);

  StreamSubscription? _subscriptionName;
  var time;
  @override
    void initState() {
    _nameFieldTextController.clear();
    Database.getNameStream(widget.taskKey, _updateName)
        .then((StreamSubscription s) => _subscriptionName = s);
    super.initState();
  }
  @override
    void dispose() {
        if (_subscriptionName != null) {
          _subscriptionName!.cancel();
        }
        super.dispose();
      }
  @override
      Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: DefaultTabController(
            length : 2,
            child : Scaffold(
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      child: UserAccountsDrawerHeader (
                        decoration: const BoxDecoration(color: Colors.blueAccent),
                        accountName: const Text('Фрактал'),
                        accountEmail: const Text("home@dartflutter.ru"),
                        currentAccountPicture: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.red,
                            )
                        ),
                      ),
                    ),
                    ListTile(
                        title: const Text("О себе"),
                        leading: const Icon(Icons.account_box),
                        onTap: (){

                        }
                    ),
                    ListTile(
                        title: const Text("Настройки"),
                        leading: const Icon(Icons.settings),
                        onTap: (){}
                    )
                  ],
                ),
              ),
              appBar : AppBar(
                  title : const Text("FRACTAL",style: TextStyle(
                      fontFamily: "fonts/Cuprum.ttf",
                      fontSize: 27.57,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      height: 1.27
                  )
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.notifications_active),
                      onPressed: () {},),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app_sharp),
                      onPressed: (){
                        AuthService().logOut();
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                        print("Выход из профиля! $context");
                      },
                    ),
                  ],
                  centerTitle: true,
                  bottom : TabBar(
                      indicatorColor: const Color.fromRGBO(0, 136, 255, 1.0),
                      indicatorWeight: 4,
                      labelPadding: const EdgeInsets.all(0),
                      tabs : [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 1.0),),
                            child: Text( "ЗАПЛАНИРОВАННО".toUpperCase(),
                                style:
                                const TextStyle(
                                    color: const Color.fromRGBO(0, 119, 239,1) ,
                                    fontSize: 16,
                                    height: 1.5,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "fonts/Roboto-Regular.ttf")),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                            child: Text( "ВЫПОЛНЕНИЕ".toUpperCase(),style:const TextStyle(
                                color: const Color.fromRGBO(0, 119, 239, 1.0) ,
                                fontSize: 16,
                                height: 1.5,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w700,
                                fontFamily: "fonts/Roboto-Regular.ttf")),
                          ),
                        ),
                      ] /* End TabBar.tabs. */
                  ) /* End TabBar. */
              ), /* End AppBar. */
              body : TabBarView(
                  children : [

                  TaskList(title:widget.nameCluster, clusterKey: widget.taskKey,color:widget.color,),
                    TaskListResult(title: widget.nameCluster, clusterKey: widget.taskKey,color: widget.color,)
                  ] /* End TabBarView.children. */
              ), /* End TabBarView. */
            ) /* End Scaffold. */
        ) /* End DefaultTabController. */,
      );
    }
    void _updateName(String name) {
      _nameFieldTextController.value = _nameFieldTextController.value.copyWith(
        text: name,
      );
    }
}