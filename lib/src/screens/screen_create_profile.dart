import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_vacancies/src/models/job_users_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

// import 'package:job_vacancies/src/screens/screen_home.dart';
// test
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

  // image picker
  File? image;

  Future pickImage({required ImageSource source}) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePermanent = await saveImagePermanently(imagePath: image.path);
      setState(() => this.image = imagePermanent);
    } on PlatformException catch (e) {
      // this exception occur when user has denied the app to access gallery
      debugPrint('failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently({required String imagePath}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String name = basename(imagePath);
    final File image = File('${directory.path}/$name');
    final Future<File> theImage = File(imagePath).copy(image.path);
    debugPrint('directory: $directory');
    debugPrint('name: $name');
    debugPrint('image: $image');
    debugPrint('theImage: $theImage');
    return theImage;
  }
  // end of image picker

  // Create a storage reference from our app
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  // StorageReference storageRef = storage.getReference();

  uploadImage(File file) {
    // if (image == null) return;
    // final String imageName = basename(image!.path);
    // final destination = 'images/$imageName';

    // FirebaseApi.uploadImage(destination: destination, imageUploadTask: image!);

    // TODO: userImages/something.jpg
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("users/userImages");
    // final spaceRef = storageRef.child("userImages/something.jpg");

    debugPrint('storageRef: $storageRef');
    debugPrint('imagesRef: $imagesRef');

    imagesRef.putFile(file);
  }

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
    final String imageName =
        image != null ? basename(image!.path) : 'no file selected';

    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${widget.user}'),
                ),
                // Text('\nuser.uid: ${widget.user?.uid}'),
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
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
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
                                color:
                                    const Color.fromARGB(255, 124, 124, 124)),
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

            // image picker
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  image != null
                      ? ClipOval(
                          child: Image.file(
                            image!,
                            width: 201,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const FlutterLogo(),
                  ElevatedButton(
                      onPressed: () {
                        pickImage(source: ImageSource.gallery);
                      },
                      child: const Text('Pick image from gallery')),
                  ElevatedButton(
                      onPressed: () {
                        pickImage(source: ImageSource.camera);
                      },
                      child: const Text('Take picture')),
                  Text(imageName),
                  ElevatedButton(
                      onPressed: () {
                        uploadImage(File(image!.path));
                      },
                      child: const Text('Upload The Image to cloud. <3')),
                ],
              ),
            ),

            // create profile button
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 30, 30, 0),
              child: ElevatedButton(
                onPressed: () async {
                  // "name": controllerName.text,
                  // "phone": controllerPhone.text,
                  // "city": selectedCity,
                  // "job_category": selectedJob,
                  // "email": widget.user!.email,
                  // "uid": widget.user!.uid,

                  if (widget.user != null) {
                    JobUserModel theUser = JobUserModel(
                      name: controllerName.text,
                      phoneNumber: controllerPhone.text,
                      jobCategory: selectedJob!, // it won't be null.
                      city: selectedCity ??
                          cities[
                              0], // if it was null the first object in the cities list.
                      email: widget.user!
                          .email!, // it won't be null, bcz user registers using the email and password.
                      uid: widget.user!.uid,
                      // imageUrl:
                    );

                    // TODO: fix bug here important
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.user!.uid)
                        .set(theUser.toMap())
                        .catchError((err) => debugPrint(err))
                        .then((value) => debugPrint('done'));
                  }
                },
                child: const Text('Create Pprofile'),
              ),
            ),
          ],
        ),
      ),
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

// class FirebaseApi {
//   static UploadTask? uploadImage(
//       {required String destination, required File imageUploadTask}) {
//     try {
//       final ref = FirebaseStorage.instance.ref(destination);
//       return ref.putFile(imageUploadTask);
//     } on FirebaseException catch (e) {
//       return null;
//     }
//   }
// }
