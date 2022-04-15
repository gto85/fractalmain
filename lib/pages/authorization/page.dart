import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'bloc.dart';
import 'configurations.dart';
import 'screen.dart';

class AuthListPage extends BlocMaterialPage<AuthListPageConfiguration, AuthListBloc> {
  static const factoryKey = 'AuthList';

  AuthListPage() : super(
    key: const ValueKey(factoryKey),
    bloc: AuthListBloc(),
    createScreen: (b) => AuthListScreen(bloc: b),
  );
}