import 'package:firebase_database/firebase_database.dart';
import 'package:fractal/models/task_list.dart';
import '../data/database.dart';

TaskList taskRepository(String clusterKey)  {
    TaskList list=TaskList("aRsQdzq","Фрактал",360);
    Database.queryTasks(clusterKey).then((Query query) {

    });
    return list;
}