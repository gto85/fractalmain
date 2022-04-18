import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../../../router/tab_enum.dart';
import 'page.dart';
import '../configurations.dart';


class OtpDetailsPageConfiguration extends PageConfiguration {
  final int otpID;

  static final _regExp = RegExp(r'^/otp/(\d+)$');

  OtpDetailsPageConfiguration({
    required this.otpID,
  }) : super(
    key: OtpDetailsPage.formatKey(otpID: otpID),
    factoryKey: OtpDetailsPage.factoryKey,
    state: {'otpID': otpID},
  );

  @override
  RouteInformation restoreRouteInformation() {
    return RouteInformation(
      location: '/otp/$otpID',
    );
  }

  static OtpDetailsPageConfiguration? tryParse(RouteInformation ri) {
    final matches = _regExp.firstMatch(ri.location ?? '');
    if (matches == null) return null;

    final otpID = int.tryParse(matches[1] ?? '');

    if (otpID == null) {
      return null; // Will never get here with present _regExp.
    }

    return OtpDetailsPageConfiguration(
      otpID: otpID,
    );
  }

  @override
  PageStackConfiguration get defaultStackConfiguration {
    return PageStackConfiguration(
      pageConfigurations: [
         AuthPageConfiguration(authId: ''),
        this,
      ],
    );
  }

  @override
  String get defaultStackKey => TabEnum.balance.name;
}