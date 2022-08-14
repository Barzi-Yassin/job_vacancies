import 'package:flutter/material.dart';

class ScreenCreateProfile extends StatelessWidget {
  ScreenCreateProfile({Key? key}) : super(key: key);

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();

  final Color primaryColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Profile'),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Name'),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: _userNameController,
            ),
            const SizedBox(height: 20),
            const Text('Phone'),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: _userPhoneController,
            ),
            const SizedBox(height: 30),
              ElevatedButton(onPressed: () {}, style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor)
              ), child: const Text('Create')),

          ],
        ),
      ),
    );
  }
}
