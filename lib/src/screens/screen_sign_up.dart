import 'package:flutter/material.dart';
import 'package:job_vacancies/src/screens/screen_create_profile.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({Key? key}) : super(key: key);
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();

  final Color primaryColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'sign up'.toUpperCase(),
          style: const TextStyle(letterSpacing: 1.5),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(020.0),
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Email'),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: _userEmailController,
              ),
              const SizedBox(height: 20),
              const Text('Password'),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: _userPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 30,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Already have account?',
                      style: TextStyle(color: Colors.black54),
                    )),
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor)
              ), child: const Text('Sign up'),),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>   ScreenCreateProfile(),
                        ));
                  },
                  child: const Text('next'))
            ],
          ),
        ),
      ),
    );
  }
}
