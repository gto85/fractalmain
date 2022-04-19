import 'package:app_state/app_state.dart';
import 'package:fractal/pages/planed/configurations.dart';

import '../../../main.dart';
import 'configurations.dart';


class OtpBloc extends PageBloc<OtpDetailsPageConfiguration> {
  void goToPIN() {
    print("OTPBloc");
  }
  @override
  OtpDetailsPageConfiguration getConfiguration() => OtpDetailsPageConfiguration(otpID: 443);
}