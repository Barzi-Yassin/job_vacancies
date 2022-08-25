import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_vacancies/src/models/job_users_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ScreenMessagesView extends StatelessWidget {
  const ScreenMessagesView({
    Key? key,
    required this.userConstructorfromScreenHome,
    required this.userModelConstructorfromScreenHome,
  }) : super(key: key);

  final UserCredential userConstructorfromScreenHome;
  final JobUserModel userModelConstructorfromScreenHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'open vacancies'.toUpperCase(),
          // style: const TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            // header section
            Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.yellow,
              // height: 75,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                // get only user credential (uid, email, so on...)
                // "${userConstructorfromScreenHome.user!.email}\n${userConstructorfromScreenHome.user!.uid}",
                userModelConstructorfromScreenHome.email,
                style: const TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            // body section
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return const OutputContainerWidget(
                    userName: "username",
                    company: "company",
                    roleDescription: "role descriptiion",
                    url: 'https://www.google.com/',
                  );
                },
              ),
            ),
            // inputs section
            const Divider(
              color: Colors.black26,
              height: 2,
              thickness: 1,
            ),
            Container(
              height: 240,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 230,
                    margin: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Column(
                      children: [
                        const InputContainer(hintText: 'company/org'),
                        const InputContainer(hintText: 'role'),
                        const InputContainer(hintText: 'Url'),
                        Container(
                          // color: Colors.yellow,
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.lightBlue.shade50,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'SEND',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.blue,
          width: 0.8,
        ),
      ),
      width: double.infinity,
      height: 50,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '${hintText.toUpperCase()}:',
        ),
      ),
    );
  }
}

class OutputContainerWidget extends StatelessWidget {
  const OutputContainerWidget({
    Key? key,
    required this.userName,
    required this.company,
    required this.roleDescription,
    required this.url,
  }) : super(key: key);

  final String userName;
  final String company;
  final String roleDescription;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.blue.shade200,
          width: 1.50,
        ),
      ),
      width: double.infinity,
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      alignment: Alignment.center,
      //  inside_box_messages-column
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 8.0),
            child: Text(
              // 'username'.toUpperCase(),
              userName.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
            child: Text(
              // 'company'.toUpperCase(),
              company.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 30.0),
            child: Text(
              // 'role description'.toUpperCase(),
              roleDescription.toUpperCase(),
              style: const TextStyle(
                  color: Colors.grey, fontSize: 11, height: 1.4),
              textAlign: TextAlign.start,
              maxLines: 3,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 15),
            // color: Colors.red,
            child: InkWell(
              child: Text(
                'LINK',
                style: TextStyle(color: Colors.blue.shade300),
              ),
              onTap: () {
                launchUrlString(url);
              },
            ),
          ),
        ],
      ),
    );
  }
}
