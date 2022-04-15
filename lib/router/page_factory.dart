import 'package:app_state/app_state.dart';

import '../pages/authorization/page.dart';


class PageFactory {
  static AbstractPage<PageConfiguration>? createPage(
      String factoryKey,
      Map<String, dynamic> state,
      ) {
    switch (factoryKey) {
      case AuthPage.factoryKey: return AuthPage();
    }

    return null;
  }
}