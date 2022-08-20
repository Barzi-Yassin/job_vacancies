import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';
// import 'package:job_vacancies/src/screens/screen_home.dart';

class ScreenCreateProfile extends StatefulWidget {
  const ScreenCreateProfile({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  State<ScreenCreateProfile> createState() => _ScreenCreateProfileState();
}

class _ScreenCreateProfileState extends State<ScreenCreateProfile> {
  String? selectedCity;
  String? selectedJob;

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();

  @override
  void initState() {
    debugPrint('init state run');
    selectedCity = cities[0];
    selectedJob = jobs[0];
    // TODO: implement initState
    super.initState();
  }

  final List<String> cities = [
    'Erbil',
    'Slemany',
    'Duhok',
    'Halabja',
  ];

  final List<String> jobs = [
    'Flutter Developer',
    'fullstack developer',
    'web developer',
    'chief executive officer',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // Text('${widget.user}'),
              Text('\nuser.uid: ${widget.user?.uid}'),
              const SizedBox(height: 20),

              // name
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 240, 0),
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: controllerName,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          // phone
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 240, 0),
                child: Text(
                  'Phone',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: controllerPhone,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 255, 0),
                child: Text(
                  'City',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  height: 50,
                  child: CustomDropdownButton2(
                    buttonWidth: 300,
                    hint: 'select city',
                    buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromARGB(255, 124, 124, 124)),
                        color: const Color.fromARGB(255, 237, 237, 237)),
                    dropdownItems: cities,
                    value: selectedCity,
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                        debugPrint(selectedCity!);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 220, 0),
                child: Text(
                  'Job Category',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                    height: 50,
                    child: CustomDropdownButton2(
                      buttonWidth: 300,
                      hint: 'select job',
                      buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 124, 124, 124)),
                          color: const Color.fromARGB(255, 237, 237, 237)),
                      dropdownItems: jobs,
                      value: selectedJob,
                      onChanged: (value) {
                        setState(() {
                          selectedJob = value;
                          debugPrint(selectedJob!);
                        });
                      },
                    )),
              )
            ],
          ),
          // const RadioGroup(),

          // create button
          Padding(
            padding: const EdgeInsets.fromLTRB(200, 30, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: firestore
                // (1) on users collection >
                // (2) create a document and id it >
                // (3) get the id from the constructor >
                // (4) fill the document with the user data from this field.

                if (widget.user != null) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.user!.uid)
                      .set({
                    "name": controllerName.text,
                    "phone": controllerPhone.text,
                    "city": selectedCity,
                    "job_category": selectedJob,
                    "email": widget.user!.email,
                    "uid": widget.user!.uid,
                  });
                }
              },
              child: const Text('Create Pprofile'),
            ),
          ),
        ],
      )),
    );
  }
}

class RadioGroup extends StatefulWidget {
  const RadioGroup({Key? key}) : super(key: key);

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  var _list = ["Employeed", "Unemployeed"];

  var _indexHorizontal = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: (FlutterRadioGroup(
          titles: _list,
          labelStyle: const TextStyle(color: Colors.white38),
          labelVisible: true,
          activeColor: const Color.fromARGB(255, 155, 10, 58),
          titleStyle: const TextStyle(fontSize: 14),
          defaultSelected: _indexHorizontal,
          orientation: RGOrientation.VERTICAL,
          onChanged: (index) {
            setState(() {
              _indexHorizontal = index!;
            });
          })),
    );
  }
}
