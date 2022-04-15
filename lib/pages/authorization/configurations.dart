import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';
import 'package:fractal/router/tab_enum.dart';

class AuthListPageConfiguration extends PageConfiguration {
  static const _location = '/auth';

  const AuthListPageConfiguration() : super(key: 'AuthList');

  @override
  RouteInformation restoreRouteInformation() {
    return const RouteInformation(
      location: _location,
    );
  }
  static AuthListPageConfiguration? tryParse(RouteInformation ri) {
    return ri.location == _location
        ? const AuthListPageConfiguration()
        : null;
  }

  @override
  String get defaultStackKey => TabEnum.auth.name;
}