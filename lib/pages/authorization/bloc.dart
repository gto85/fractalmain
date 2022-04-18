import 'package:app_state/app_state.dart';
import 'package:fractal/pages/planed/configurations.dart';

import '../../main.dart';

import 'configurations.dart';
import 'otp/page.dart';

class AuthBloc extends PageBloc<AuthPageConfiguration> {
  void OtpDetails() {
    pageStacksBloc.currentStackBloc?.push(OtpDetailsPage(otpID: 11));
  }

  @override
  AuthPageConfiguration getConfiguration() => AuthPageConfiguration(authId: '');
}