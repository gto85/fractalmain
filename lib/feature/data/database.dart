import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fractal/feature/balance_plan/balance_screen_plan_day.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class Database {
  static Future<Query> queryTasks(String key) async {
    String accountKey = await _getAccountKey();
    // print(key);
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(key)
        .child("tasks")
        .orderByChild("name");

  }
  static Future<void> delClusterTask(String? clusterkey,String? taskKey) async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey!)
        .child("tasks")
        .child(taskKey!)
        .remove();
  }
  static Future<void> saveName(String clusterkey, String name) async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey)
        .child("name")
        .set(name);
  }
  static Future<void> saveTask(String clusterkey,String taskkey, String name) async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey)
        .child("tasks")
        .child(taskkey)
        .child("name")
        .set(name);
  }
  static Future<void> saveTaskCompl(String clusterkey,String taskkey, bool compl) async {
    String accountKey = await _getAccountKey();
    // print("Сохранение галочки задачи!!!");
    // print("clusterkey: $clusterkey taskkey: $taskkey compl: $compl");
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey)
        .child("tasks")
        .child(taskkey)
        .child("completed")
        .set(compl);

  }
  static Future<void> delCluster(String? clusterkey) async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey!)
        .remove();
  }
  static Future<String> createClusters() async {
    String accountKey = await _getAccountKey();
    var cluster = <String, dynamic>{
      'name' : '',
      'created': _getDateNow(),
      "color": "0xFFFF9435",
      "idCluster":1,
      "timeCluster":0,
    };

    DatabaseReference reference = FirebaseDatabase.instance.ref().child("accounts").child(accountKey).child("Clusters").push();
    reference.set(cluster);
    return reference.key!;
  }
  static Future<String> createTasksFirst() async {
    String accountKey = await _getAccountKey();
    var cluster1 = <String, dynamic>{
      'name' : '',
      'created': _getDateNow(),
      "idTask":1,
      "timeTask":0,
      "completed":false,
      "completedTimeTask":0,
    };
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters");
    DatabaseReference reference1 = reference
        .child(reference.key!)
        .child('tasks')
        .push();

    reference1.set(cluster1);
    return reference.key!;
  }
  static Future<void> createTasks(String? clusterkey,String? name,String? time,) async {
    var cluster1 = <String, dynamic>{
      'name' : name,
      'created': _getDateNow(),
      "idTask":1,
      "timeTask":int.parse(time!),
      "completedTimeTask":0,
      "completed":false,
    };
    String accountKey = await _getAccountKey();
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters");

    DatabaseReference reference1 = reference
        .child(clusterkey!)
        .child('tasks')
        .push();

    reference1.set(cluster1);
  }
  static Future<void> createComplTask(String? clusterkey,String? taskKey,String? name,String? nameCluster,String? time, String? color) async {
    var complTimePart = <String, dynamic>{
      'nameCluster' : nameCluster,
      'name' : name,
      'color':color,
      'dataCreate': _getDateNow(),
      "idTask":taskKey,
      "idCluster":clusterkey,
      "time":time,
    };
    String accountKey = await _getAccountKey();
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("TimeComplTasks");

    DatabaseReference reference1 = reference
        .push();

    reference1.set(complTimePart);
    // print("Выполненная задача создана!");
  }
  static Future<List<CharNeed>?> getCharNeeds() async {
    String accountKey = await _getAccountKey();
    Query charNeedsSnapshot = FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .orderByKey();
    List<CharNeed> chNeed=[];
    await charNeedsSnapshot.once().then((snap) {
     var map =  snap.snapshot.value;
     var map1=Map<String, dynamic>.from(map as Map);
     map1.forEach((key, value) {
       chNeed.add(CharNeed(value['timeCluster']/60*100/24, value['name'], Color(int.parse("${value['color']}"))));
     });
    });
    return chNeed;
  }
  static Future<List<CharNeed>?> getCharNeedsMin() async {
    String accountKey = await _getAccountKey();
    Query _charNeedsSnapshot = FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .orderByKey();
    List<CharNeed> _chNeed=[];
    await _charNeedsSnapshot.once().then((snap) {
      var map =  snap.snapshot.value;
      var map1=Map<String, dynamic>.from(map as Map);
      map1.forEach((key, value) {
        _chNeed.add(CharNeed(double.parse(value['timeCluster'].toString()), value['name'], Color(int.parse("${value['color']}"))));
      });
    });
    return _chNeed;
  }
  static Future<List<CharNeed>?> getResultCharNeeds(int period) async {

    List<CharNeed> chNeed=[];
    String accountKey = await _getAccountKey();
    if (period==1) {
      period=0;
    }
    DateTime startDate = DateTime.now().subtract(Duration(days:period));
    DateTime endDate = DateTime.now();

    Query charNeedsSnapshot = FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("TimeComplTasks");
    // for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    //   await charNeedsSnapshot.once().then((DatabaseEvent dataSnapshot){
    //     for(var value in dataSnapshot.snapshot.value) {
    //       if (value['dataCreate'].toString().substring(0,10) == "${endDate.subtract(Duration(days:i)).year.toString()}-"
    //           "${endDate.subtract(Duration(days:i)).month<10?
    //       "0"+endDate.subtract(Duration(days:i)).month.toString()
    //           :
    //       endDate.subtract(Duration(days:i)).month.toString()}-"
    //           "${endDate.subtract(Duration(days:i)).day<10?
    //       "0"+endDate.subtract(Duration(days:i)).day.toString()
    //           :
    //       endDate.subtract(Duration(days:i)).day.toString()}") {
    //         chNeed.add(CharNeed(double.parse(value['time']), value['nameCluster'], Color(int.parse("${value['color']}"))));
    //       }
    //     }
    //   });
    // }
    return chNeed;
  }
  static Future<Query> TimeClusters() async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .orderByChild("value");

  }
  static Future<void> saveTaskTime(String clusterkey,String taskkey, int val) async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey)
        .child("tasks")
        .child(taskkey)
        .child("timeTask")
        .set(val);
  }
  static Future<void> setClusterTime(String clusterkey,int timeClust) async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey)
        .child("timeCluster")
        .set(timeClust);
  }
  static Future<void> saveColor(String clusterkey, String color) async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey)
        .child('color')
        .set(color);
  }
  static Future<StreamSubscription<DatabaseEvent>> getNameStream(String clusterkey,
      void Function(String name) onData) async {
    String accountKey = await _getAccountKey();

    StreamSubscription<DatabaseEvent> subscription = FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .child(clusterkey)
        .child("name")
        .onValue
        .listen((DatabaseEvent event) {
      String name = event.snapshot.value as String;
      name ??= "";
      onData(name);
    });
    // print("111");
    return subscription;
  }
  static Future<Query> queryClusters() async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("Clusters")
        .orderByChild("value");

  }
  static Future<Query> queryClustersResult() async {
    String accountKey = await _getAccountKey();
    return FirebaseDatabase.instance
        .ref()
        .child("accounts")
        .child(accountKey)
        .child("TimeComplTasks");
  }
}
Future<String> _getAccountKey() async {
  return FirebaseAuth.instance.currentUser!.uid;
}
String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now.add(const Duration(hours: 0)));
}