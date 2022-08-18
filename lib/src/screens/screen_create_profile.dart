
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';
import 'package:job_vacancies/src/screens/screen_home.dart';
// import 'package:open_vacancies/src/screens/home_screen.dart';

class ScreenCreateProfile extends StatelessWidget {
  const ScreenCreateProfile({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children:  [
            Text('$user'),
            Text('\nuser.uid: ${user!.uid}'),
            const SizedBox(
              height: 90,
            ),
            const NameField(),
            const SizedBox(
              height: 8,
            ),
            const PhoneField(),
            const SizedBox(
              height: 8,
            ),
            const CityField(),
            const SizedBox(
              height: 8,
            ),
            const JobCatagory(),
            const RadioGroup(),
            const CreateButton()
          ],
        ),
      )),
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
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
              obscureText: false,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
            ),
          ),
        )
      ],
    ));
  }
}

class PhoneField extends StatelessWidget {
  const PhoneField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Column(
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
              obscureText: false,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
            ),
          ),
        )
      ],
    ));
  }
}

class CityField extends StatefulWidget {
  const CityField({Key? key}) : super(key: key);

  @override
  State<CityField> createState() => _CityFieldState();
}

class _CityFieldState extends State<CityField> {
  final List<String> cities = [
    'Erbil',
    'Slemany',
    'Duhok',
    'Halabja',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    initState() {
      super.initState();
      selectedValue = cities[0];
    }

    return (Column(
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
                      border:
                          Border.all(color: const Color.fromARGB(255, 124, 124, 124)),
                      color: const Color.fromARGB(255, 237, 237, 237)),
                  dropdownItems: cities,
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      debugPrint(selectedValue!);
                    });
                  },
                )))
      ],
    ));
  }
}

class JobCatagory extends StatefulWidget {
  const JobCatagory({Key? key}) : super(key: key);

  @override
  State<JobCatagory> createState() => _JobCatagoryState();
}

class _JobCatagoryState extends State<JobCatagory> {
  final List<String> jobs = [
    'Flutter Developer',
    'fullstack developer',
    'web developer',
    'chief executive officer',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return (Column(
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
                hint: 'select city',
                buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color.fromARGB(255, 124, 124, 124)),
                    color: const Color.fromARGB(255, 237, 237, 237)),
                dropdownItems: jobs,
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    debugPrint(selectedValue!);
                  });
                },
              )),
        )
      ],
    ));
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

class CreateButton extends StatelessWidget {
  const CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(200, 30, 0, 0),
      child: (ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const ScreenHome())));
          },
          child: const Text('Create Profile'))),
    );
  }
}
