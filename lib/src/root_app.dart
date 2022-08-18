import 'package:flutter/material.dart';
import 'package:job_vacancies/src/screens/screen_create_profile.dart';
import 'package:job_vacancies/src/screens/screen_sign_in.dart';
import 'package:job_vacancies/src/screens/screen_sign_up.dart';

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenSignUp(),
      routes: {
        '/signIn' :(context) => ScreenSignIn(),
        '/signUP' :(context) => ScreenSignUp(),
        '/createProfile' :(context) => ScreenCreateProfile(),
      },
    );
  }
}
