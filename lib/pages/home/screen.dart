import 'package:app_state/app_state.dart';
import 'package:keyed_collection_widgets/keyed_collection_widgets.dart';
import 'package:flutter/material.dart';
import '../../router/tab_enum.dart';
import '../../screens/loginScreen.dart';
import '../../widgets/progress_screen_widget.dart';

class HomeScreen extends StatelessWidget {
  final PageStacksBloc bloc;

  AuthStatus authStatus = AuthStatus.LOGGED_OUT;
  HomeScreen({
    required this.bloc
  });

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return progressScreenWidget();
      case AuthStatus.LOGGED_OUT:
        return  const LoginScreen();
      case AuthStatus.LOGGED_IN:
        if (authStatus!= null) {
          return  StreamBuilder(
            stream: bloc.events,
            builder: (context, snapshot) => _buildOnEvent(),
          );
        } else {
          return progressScreenWidget();
        }
      default:
        return progressScreenWidget();
    }
  }

  Widget _buildOnEvent() {
    final tab = TabEnum.values.byName(bloc.currentStackKey!);
    return Scaffold(

      body:KeyedStack<TabEnum>(
        itemKey: tab,
        children: bloc.pageStacks.map((tabString, bloc) => MapEntry(
            TabEnum.values.byName(tabString),
            PageStackBlocNavigator(key: ValueKey(tabString), bloc: bloc)),
        ),
      ),
      bottomNavigationBar: KeyedBottomNavigationBar<TabEnum>(
        currentItemKey: tab,
        items: const {
          TabEnum.balance: BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Баланс',
          ),
          TabEnum.statistics: BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Статистика',
          ),
          TabEnum.profile: BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Профиль',
          ),
        },
        onTap: (tab) => bloc.setCurrentStackKey(tab.name),
      ),
    );
  }
}