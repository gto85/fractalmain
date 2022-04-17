import 'package:flutter/material.dart';
import 'bloc.dart';

class PlanedScreen extends StatelessWidget {
  final PlanedBloc bloc;
  PlanedScreen({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          for (var planed in ["planedRepository"])
            ListTile(

            ),
        ],
      ),
    );
  }
}