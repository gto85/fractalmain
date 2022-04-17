import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';
import '../../../repositories/task_list.dart';
import 'configurations.dart';
import 'screen.dart';

class TaskListPage extends StatelessMaterialPage<PageConfiguration> {
  static const factoryKey = 'TaskDetails';

  TaskListPage({
    required String taskId,
  }) : super(
    key: ValueKey(formatKey(taskId: taskId)),
    child: TaskDetailsScreen(tasks:taskRepository(taskId)),
    configuration: TaskListPageConfiguration(taskId: taskId),
  );

  static String formatKey({required String taskId}) {
    return '${factoryKey}_$taskId';
  }
}