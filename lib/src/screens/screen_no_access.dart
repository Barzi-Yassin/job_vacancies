import 'package:flutter/material.dart';

class ScreenNoAccess extends StatelessWidget {
  const ScreenNoAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('You don\'t have access to thos screen, register or login'),
      ),
    );
  }
}