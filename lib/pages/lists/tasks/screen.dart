import 'package:flutter/material.dart';
import 'package:fractal/models/task_list.dart';


class TaskDetailsScreen extends StatelessWidget {
  final TaskList tasks;
  TaskDetailsScreen({
    required this.tasks,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tasks.taskName, style: Theme.of(context).textTheme.headline6),
            Text(tasks.timeTask.toString(), style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}