import 'package:app_state/app_state.dart';

import '../pages/authorization/page.dart';


class PageFactory {
  static AbstractPage<PageConfiguration>? createPage(
      String factoryKey,
      Map<String, dynamic> state,
      ) {
    switch (factoryKey) {
      case AuthPage.factoryKey: return AuthPage();
      case BookDetailsPage.factoryKey: return BookDetailsPage(bookId: state['bookId']);
      case BookListPage.factoryKey: return BookListPage();
      case InputPage.factoryKey: return InputPage(name: '');
    }

    return null;
  }
}