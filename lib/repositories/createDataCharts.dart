
import 'dart:core';
import 'package:collection/src/iterable_extensions.dart';
import 'package:fractal/data/database.dart';
import 'package:fractal/models/char_needs.dart';


// var temp=Database.getNeeds();
poluchMin(list) async {
  List? fileContent= await downLdFieMin();
  // print({"poluchMin: ${list}"});
  return fileContent!.forEach((element) {
    list.add(element);
  });
}
Future<List?> downLdFieMin() async {
  List? result= await Database.getCharNeedsMin();
  // print(result.runtimeType);
  return result;
}
poluch(_list,per) async {
  List? _fileContent= await downLdFie(per);
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
  List? planResult= await Database.getCharNeeds();
  List? tempResult= await Database.getResultCharNeeds(period);
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
Future<List?> downLdFie(int period) async {
  List? result= await Database.getResultCharNeeds(period);
  // print(result.runtimeType);
  return result;
}
printFileContent(list) async {
  List? fileContent= await downLoadFile();
  // print(list);
  return fileContent!.forEach((element) {
    list.add(element);
  });
}
Future<List?> downLoadFile() async {
  List? result= await Database.getCharNeeds();
  // print(result.runtimeType);
  return result;
}
getCheckList(list) async {
  List? fileContent= await getDataChList();
  // print(list);
  return fileContent!.forEach((element) {
    list.add(element);
  });
}
Future<List?> getDataChList() async {
  List? result= await Database.getCharNeeds();
  // print(result.runtimeType);
  return result;
}
