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
  _EditTaskPageState createState() => new _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _nameFieldTextController = new TextEditingController();
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
      return new Scaffold(
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
                        decoration: BoxDecoration(color: Colors.blueAccent),
                        accountName: Text('Фрактал'),
                        accountEmail: Text("home@dartflutter.ru"),
                        currentAccountPicture: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.red,
                            )
                        ),
                      ),
                    ),
                    new ListTile(
                        title: new Text("О себе"),
                        leading: Icon(Icons.account_box),
                        onTap: (){

                        }
                    ),
                    new ListTile(
                        title: new Text("Настройки"),
                        leading: Icon(Icons.settings),
                        onTap: (){}
                    )
                  ],
                ),
              ),
              appBar : AppBar(
                  title : Text("FRACTAL",style: TextStyle(
                      fontFamily: "fonts/Cuprum.ttf",
                      fontSize: 27.57,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      height: 1.27
                  )
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.notifications_active),
                      onPressed: () {},),
                    IconButton(
                      icon: Icon(Icons.exit_to_app_sharp),
                      onPressed: (){
                        AuthService().logOut();
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                        print("Выход из профиля! $context");
                      },
                    ),
                  ],
                  centerTitle: true,
                  bottom : TabBar(
                      indicatorColor: Color.fromRGBO(0, 136, 255, 1.0),
                      indicatorWeight: 4,
                      labelPadding: EdgeInsets.all(0),
                      tabs : [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1.0),),
                            child: Text( "ЗАПЛАНИРОВАННО".toUpperCase(),
                                style:
                                TextStyle(
                                    color: Color.fromRGBO(0, 119, 239,1) ,
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
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                            child: Text( "ВЫПОЛНЕНИЕ".toUpperCase(),style:TextStyle(
                                color: Color.fromRGBO(0, 119, 239, 1.0) ,
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