import 'package:app_state/app_state.dart';
import 'package:fractal/pages/planed/configurations.dart';

import '../../../main.dart';


class OtpBloc extends PageBloc<OtpPageConfiguration> {
  void goToPIN() {
    print("OTPBloc");
  }
  @override
  PlanedPageConfiguration getConfiguration() => PlanedPageConfiguration();
}