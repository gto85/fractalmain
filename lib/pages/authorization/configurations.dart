import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';
import 'package:fractal/router/tab_enum.dart';

import 'page.dart';

class AuthPageConfiguration extends PageConfiguration {
  final String authId;

  static final _regExp = RegExp(r'^/auth/(\d+)$');

  AuthPageConfiguration({
    required this.authId,
  }) : super(
    key: AuthPage.formatKey(authId: authId),
    factoryKey: AuthPage.factoryKey,
    state: {'authId': authId},
  );

  @override
  RouteInformation restoreRouteInformation() {
    return RouteInformation(
      location: '/auth/$authId',
    );
  }

  static AuthPageConfiguration? tryParse(RouteInformation ri) {
    final matches = _regExp.firstMatch(ri.location ?? '');
    if (matches == null) return null;

    final authId = int.tryParse(matches[1] ?? '');

    if (authId == null) {
      return null; // Will never get here with present _regExp.
    }

    return AuthPageConfiguration(
      authId: authId,
    );
  }

  @override
  PageStackConfiguration get defaultStackConfiguration {
    return PageStackConfiguration(
      pageConfigurations: [
        AuthPageConfiguration(authId: null),
        this,
      ],
    );
  }

  @override
  String get defaultStackKey => TabEnum.auth.name;
}