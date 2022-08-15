import 'package:flutter/material.dart';

class ScreenNoAccess extends StatelessWidget {
  const ScreenNoAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      // to avoid going back a level
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                  'You don\'t have access to thos screen, register or login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/signIn'),
                    child: const Text('Sign in')),
                ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/signUp'),
                    child: const Text('Sign up'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
