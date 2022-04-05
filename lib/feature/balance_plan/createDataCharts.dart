
import 'dart:core';
import 'package:collection/src/iterable_extensions.dart';
import 'package:fractal/feature/balance_plan/balance_screen_plan_day.dart';
import 'package:fractal/feature/data/database.dart';

// var temp=Database.getNeeds();
poluchMin(list) async {
  List<CharNeed>? fileContent= await downLdFieMin();
  // print({"poluchMin: ${list}"});
  return fileContent!.forEach((element) {
    list.add(element);
  });
}
Future<List<CharNeed>?> downLdFieMin() async {
  List<CharNeed>? result= await Database.getCharNeedsMin();
  // print(result.runtimeType);
  return result;
}
poluch(_list,per) async {
  List<CharNeed>? _fileContent= await downLdFie(per);
  print({"poluch: ${_list}"});
  print({"per: ${per}"});

  return _fileContent!.forEach((_element) {
    _list.add(_element);
  });
}
poluch1(_list,per) async {
  List<CharNeedResult>? _fileContent= await getDataMyChList(per);


  return _fileContent!.forEach((_element) {
    _list.add(_element);
    print({"poluch1: ${_list}"});
  });
}
Future<List<CharNeedResult>?> getDataMyChList(int period) async {
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
Future<List<CharNeed>?> downLdFie(int period) async {
  List<CharNeed>? result= await Database.getResultCharNeeds(period);
  // print(result.runtimeType);
  return result;
}
printFileContent(list) async {
  List<CharNeed>? fileContent= await downLoadFile();
  // print(list);
  return fileContent!.forEach((element) {
    list.add(element);
  });
}
Future<List<CharNeed>?> downLoadFile() async {
  List<CharNeed>? result= await Database.getCharNeeds();
  // print(result.runtimeType);
  return result;
}
getCheckList(list) async {
  List<CharNeed>? fileContent= await getDataChList();
  // print(list);
  return fileContent!.forEach((element) {
    list.add(element);
  });
}
Future<List<CharNeed>?> getDataChList() async {
  List<CharNeed>? result= await Database.getCharNeeds();
  // print(result.runtimeType);
  return result;
}
