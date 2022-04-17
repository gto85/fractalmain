import 'package:app_state/app_state.dart';
import 'package:keyed_collection_widgets/keyed_collection_widgets.dart';
import 'package:flutter/material.dart';
import '../../router/tab_enum.dart';

class HomeScreen extends StatelessWidget {
  final PageStacksBloc bloc;

  HomeScreen({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.events,
      builder: (context, snapshot) => _buildOnEvent(),
    );
  }

  Widget _buildOnEvent() {
    final tab = TabEnum.values.byName(bloc.currentStackKey!);

    return Scaffold(
      body: KeyedStack<TabEnum>(
        itemKey: tab,
        children: bloc.pageStacks.map((tabString, bloc) => MapEntry(
            TabEnum.values.byName(tabString),
            PageStackBlocNavigator(key: ValueKey(tabString), bloc: bloc)),
        ),
      ),
      bottomNavigationBar: KeyedBottomNavigationBar<TabEnum>(
        currentItemKey: tab,
        items: const {
          TabEnum.auth: BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Authorization',
          ),
          TabEnum.planned: BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Planned',
          ),
        },
        onTap: (tab) => bloc.setCurrentStackKey(tab.name),
      ),
    );
  }
}