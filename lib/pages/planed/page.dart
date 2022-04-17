import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'bloc.dart';
import 'configurations.dart';
import 'screen.dart';

class PlanedPage extends BlocMaterialPage<PlanedPageConfiguration, PlanedBloc> {
  static const factoryKey = 'AuthList';

  PlanedPage() : super(
    key: const ValueKey(factoryKey),
    bloc: PlanedBloc(),
    createScreen: (b) => PlanedScreen(bloc: b),
  );
}