// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_vacancies/src/screens/screen_create_profile.dart';
import 'package:job_vacancies/src/screens/screen_sign_in.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({Key? key}) : super(key: key);
  final controllerSignUpEmail = TextEditingController();
  final controllerSignUpPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 50),
              // login button from signup screen
              Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenSignIn()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "REGISTER",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 120),
              // email textfield
              Container(
                height: 60,
                width: 300,
                decoration: const BoxDecoration(color: Colors.grey),
                child: TextField(
                  controller: controllerSignUpEmail,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // password textfield
              Container(
                height: 60,
                width: 300,
                decoration: const BoxDecoration(color: Colors.grey),
                child: TextField(
                  controller: controllerSignUpPassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 50,
                width: 100,
                decoration: const BoxDecoration(color: Colors.grey),
                child: TextButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/createProfile');
                    push(context, controllerSignUpEmail,
                        controllerSignUpPassword);
                  },

                  // signup button
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color:
                            Colors.white), // `  XM89:;;FPZZa8AaFZ[\]^[]]ab♥7+♥♥
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Future<User?> push(BuildContext context, final controllerSignUpEmailParameter,
    final controllerSignUpPasswordParameter) async {
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  if (controllerSignUpEmailParameter.text == "" ||
      controllerSignUpPasswordParameter.text == "") {
    // null check
    showAlertDialog(context, "Please enter the required information");
  } else if (!emailRegExp.hasMatch(controllerSignUpEmailParameter.text)) {
    return showAlertDialog(context, "Enter a vaild Email");
  } else {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: controllerSignUpEmailParameter.text,
        password: controllerSignUpPasswordParameter.text,
      );
      delayPushSignup(context: context, userCredential: userCredential);
      user = userCredential.user;

      await user?.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlertDialog(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showAlertDialog(context, 'The account already exists for that email.');
      }
    } catch (e) {
      showAlertDialog(context, e.toString());
    }
    return user;
  }
}

Future delayPushSignup(
    {required BuildContext context,
    required UserCredential userCredential}) async {
  await Future.delayed(
    const Duration(milliseconds: 10),
    () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ScreenCreateProfile(
                  user: userCredential.user,
                )),
      );
    },
  );
}
