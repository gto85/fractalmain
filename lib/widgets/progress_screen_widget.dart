import 'package:flutter/material.dart';

Widget progressScreenWidget() {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ),
  );
}