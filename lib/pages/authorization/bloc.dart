import 'package:app_state/app_state.dart';
import 'configurations.dart';
import '../../models/user.dart';

class AuthListBloc extends PageBloc<AuthListPageConfiguration> {
  void showDetails(UserInfo1 user) {
    pageStacksBloc.currentStackBloc?.push(AuthDetailsPage(authId: user.id));
  }

  @override
  AuthListPageConfiguration getConfiguration() => const AuthListPageConfiguration();
}