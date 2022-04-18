import 'package:app_state/app_state.dart';


class AuthBloc extends PageBloc<AuthPageConfiguration> {
  void goToPIN(UserInfo1 user) {
    pageStacksBloc.currentStackBloc?.push(AuthPageConfiguration(authId: auth.id));
  }
  @override
  AuthPageConfiguration getConfiguration() => AuthPageConfiguration(authId: '');
}