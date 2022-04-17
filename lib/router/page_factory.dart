import 'package:app_state/app_state.dart';
import 'package:fractal/pages/planed/page.dart';

import '../pages/authorization/page.dart';


class PageFactory {
  static AbstractPage<PageConfiguration>? createPage(
      String factoryKey,
      Map<String, dynamic> state,
      ) {
    switch (factoryKey) {
      case AuthPage.factoryKey: return AuthPage();
      case PlanedPage.factoryKey: return PlanedPage();
    }
    return null;
  }
}