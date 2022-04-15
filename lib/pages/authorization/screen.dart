import 'package:flutter/material.dart';
import 'bloc.dart';


class AuthListScreen extends StatelessWidget {
  final AuthListBloc bloc;
  AuthListScreen({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          for (var auth in authRepository)
            ListTile(
              title: Text(auth.id),
              subtitle: Text(auth.author),
              onTap: () => bloc.showDetails(auth),
            ),
        ],
      ),
    );
  }
}