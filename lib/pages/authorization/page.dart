import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'bloc.dart';
import 'configurations.dart';
import 'screen.dart';

class AuthPage extends BlocMaterialPage<AuthPageConfiguration, AuthBloc> {
  static const factoryKey = 'Auth';

  AuthPage() : super(
    key: const ValueKey(factoryKey),
    bloc: AuthBloc(),
    createScreen: (b) => AuthScreen(bloc: b),
  );

  static formatKey({required String factoryKey, String? authId}) {}

}