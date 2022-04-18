import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';


import 'configurations.dart';
import 'screen.dart';

class OtpDetailsPage extends StatelessMaterialPage<PageConfiguration> {
  static const factoryKey = 'OtpDetails';

  OtpDetailsPage({
    required int otpID,
  }) : super(
    key: ValueKey(formatKey(otpID: otpID)),
    child: OtpDetailsScreen(codeDigits: '', phone: '',),
    configuration: OtpDetailsPageConfiguration(otpID: otpID),
  );

  static String formatKey({required int otpID}) {
    return '${factoryKey}_$otpID';
  }
}