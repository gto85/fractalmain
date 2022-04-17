import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';
import '../../../router/tab_enum.dart';
import 'page.dart';


class TaskListPageConfiguration extends PageConfiguration {
  final String taskId;
  static final _regExp = RegExp(r'^/tasks/(\d+)$');

  TaskListPageConfiguration({
    required this.taskId,
  }) : super(
    key: TaskListPage.formatKey(taskId: taskId),
    factoryKey: TaskListPage.factoryKey,
    state: {'taskId': taskId},
  );

  @override
  RouteInformation restoreRouteInformation() {
    return RouteInformation(
      location: '/tasks/$taskId',
    );
  }

  static TaskListPageConfiguration? tryParse(RouteInformation ri) {
    final matches = _regExp.firstMatch(ri.location ?? '');
    if (matches == null) return null;

    final taskId = matches[1] ?? '';

    if (taskId == null) {
      return null; // Will never get here with present _regExp.
    }

    return TaskListPageConfiguration(
      taskId: taskId,
    );
  }

  @override
  PageStackConfiguration get defaultStackConfiguration {
    return PageStackConfiguration(
      pageConfigurations: [
         TaskListPageConfiguration(taskId: ''),
        this,
      ],
    );
  }

  @override
  String get defaultStackKey => TabEnum.tasklist.name;
}