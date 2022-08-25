import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_vacancies/src/screens/screen_home.dart';

class ScreenSignIn extends StatelessWidget {
  ScreenSignIn({Key? key}) : super(key: key);
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Container(
                    height: 40,
                    width: 100,
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 60,
              ),
              //  email
              Container(
                height: 60,
                width: 300,
                decoration: const BoxDecoration(color: Colors.grey),
                child: TextField(
                  controller: myController,
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
              const SizedBox(
                height: 20,
              ),
              //  password
              Container(
                height: 60,
                width: 300,
                decoration: const BoxDecoration(color: Colors.grey),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: myController2,
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
              Padding(
                padding: const EdgeInsets.only(left: 140.0),
                child: TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Your Password?")),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.grey.shade800),
                  child: TextButton(
                      onPressed: () {
                        push(context, myController, myController2);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          )
        ],
      ),
    );
  }
}

Future push(
    BuildContext context, final myController, final myController2) async {
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  if (myController.text == "" || myController2.text == "") {
    showAlertDialog(context, "Please enter the required information");
  } else if (!emailRegExp.hasMatch(myController.text)) {
    return showAlertDialog(context, "Enter a vaild Email");
  } else {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: myController.text,
        password: myController2.text,
      );
      delayPushU(context: context, userCredential: userCredential);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDialog(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showAlertDialog(context, "Wrong password provided.");
      }
    }
  }
}

showAlertDialog(BuildContext context, String x) {
  // Create button
  Widget okButton = ElevatedButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert!"),
    content: Text(x),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// delayPushU to go to home screen
Future delayPushU(
    {required BuildContext context,
    required UserCredential userCredential}) async {
  
  
  await Future.delayed(
    const Duration(milliseconds: 10),
    () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ScreenHome(
                  userConstructorfromSignin: userCredential,
                )),
      );
    },
  );
}
