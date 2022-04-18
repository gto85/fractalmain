import 'package:app_state/app_state.dart';

import '../../main.dart';
import '../../models/user.dart';
import '../book_details/page.dart';
import 'configurations.dart';

class BookListBloc extends PageBloc<BookListPageConfiguration> {
  void OtpDetails(Book book) {
    pageStacksBloc.currentStackBloc?.push(OtpDetailsPage(bookId: book.id));
  }

  @override
  BookListPageConfiguration getConfiguration() => const BookListPageConfiguration();
}