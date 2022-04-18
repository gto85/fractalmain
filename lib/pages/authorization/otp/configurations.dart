import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import 'page.dart';
import '../configurations.dart';
import '../../router/tab_enum.dart';

class OtpDetailsPageConfiguration extends PageConfiguration {
  final int bookId;

  static final _regExp = RegExp(r'^/otp/(\d+)$');

  OtpDetailsPageConfiguration({
    required this.bookId,
  }) : super(
    key: OtpDetailsPage.formatKey(bookId: bookId),
    factoryKey: OtpDetailsPage.factoryKey,
    state: {'bookId': bookId},
  );

  @override
  RouteInformation restoreRouteInformation() {
    return RouteInformation(
      location: '/books/$bookId',
    );
  }

  static OtpDetailsPageConfiguration? tryParse(RouteInformation ri) {
    final matches = _regExp.firstMatch(ri.location ?? '');
    if (matches == null) return null;

    final bookId = int.tryParse(matches[1] ?? '');

    if (bookId == null) {
      return null; // Will never get here with present _regExp.
    }

    return OtpDetailsPageConfiguration(
      bookId: bookId,
    );
  }

  @override
  PageStackConfiguration get defaultStackConfiguration {
    return PageStackConfiguration(
      pageConfigurations: [
        const BookListPageConfiguration(),
        this,
      ],
    );
  }

  @override
  String get defaultStackKey => TabEnum.books.name;
}