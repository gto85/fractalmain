import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';
import 'package:fractal/router/tab_enum.dart';

class PlanedPageConfiguration extends PageConfiguration {
  static const _location = '/planed';

  const PlanedPageConfiguration() : super(key: 'Planed');

  @override
  RouteInformation restoreRouteInformation() {
    return const RouteInformation(
      location: _location,
    );
  }
  static PlanedPageConfiguration? tryParse(RouteInformation ri) {
    return ri.location == _location
        ? const PlanedPageConfiguration()
        : null;
  }

  @override
  String get defaultStackKey => TabEnum.auth.name;
}