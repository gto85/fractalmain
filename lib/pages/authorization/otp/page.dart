import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';


import 'configurations.dart';
import 'screen.dart';

class OtpDetailsPage extends StatelessMaterialPage<PageConfiguration> {
  static const factoryKey = 'OtpDetails';

  OtpDetailsPage({
    required int bookId,
  }) : super(
    key: ValueKey(formatKey(bookId: bookId)),
    child: OtpDetailsScreen(book: bookRepository[bookId]),
    configuration: OtpDetailsPageConfiguration(bookId: bookId),
  );

  static String formatKey({required int bookId}) {
    return '${factoryKey}_$bookId';
  }
}