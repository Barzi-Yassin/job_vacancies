import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_vacancies/src/models/job_users_model.dart';
import 'package:job_vacancies/src/screens/screen_messages_view.dart';
import 'package:job_vacancies/src/screens/screen_no_access.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome(
      {Key? key,
      required this.userConstructorfromSignin,
      required this.userModelConstructorfromSignin})
      : super(key: key);
  final UserCredential userConstructorfromSignin;
  final JobUserModel userModelConstructorfromSignin;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          debugPrint('barzy ${snapshot.data}');
          //TODO: if the is logged in return the ScreenMessagesView

          if (snapshot.data == null) {
            return const ScreenNoAccess();
          } else {
            return ScreenMessagesView(
              userConstructorfromScreenHome: userConstructorfromSignin,
              userModelConstructorfromScreenHome: userModelConstructorfromSignin,
            );
          }

          //TODO: if the is NOT logged in return that you don't have access please login
        },
      ),
    );
  }
}
