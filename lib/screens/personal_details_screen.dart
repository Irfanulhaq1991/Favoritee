import 'dart:io';

import 'package:favoritee/widget/Drawer.dart';
import 'package:flutter/material.dart';
import '../data/user/local/UserDao.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  String? imagePath;
  String firthName = "";
  String lastName = "";
  String dob = "";
  String email = "";
  String education = "";
  late UserDao userDTO;

  @override
  void initState() {
    super.initState();

    userDTO = UserDao(() {
      loadData();
    });
  }

  void loadData() async {
    List<UserDomainModel> users = await userDTO.getFromDb();
    var person = users.first;
    setState(() {
      imagePath = person.imagePath;
      firthName = person.firstName;
      lastName = person.lastName;
      dob = person.dob;
      email = person.email;
      education = person.education;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppNavigationDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Personal Details",
            style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber[600],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
                child: Card(
                    elevation: 10,
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                      child: CircleAvatar(
                          backgroundImage: imagePath == null
                              ? null
                              : FileImage(File(imagePath!)),
                          radius: MediaQuery.of(context).size.width * 0.10,
                          child: imagePath != null
                              ? null
                              : Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size:
                                      MediaQuery.of(context).size.width * 0.20,
                                )),
                    ))),
            Divider(
              thickness: 0.5,
              color: Colors.black,
              height: 50.0,
            ),
            const Text(
              "First Name",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              firthName,
              style: TextStyle(
                color: Colors.amber,
                letterSpacing: 2.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            const Text(
              "Last Name",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              lastName,
              style: TextStyle(
                color: Colors.amber,
                letterSpacing: 2.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            const Text(
              "Date of Birth",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              dob,
              style: const TextStyle(
                color: Colors.amber,
                letterSpacing: 2.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Education",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              education,
              style: const TextStyle(
                color: Colors.amber,
                letterSpacing: 2.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Email Address",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              email,
              style: const TextStyle(
                color: Colors.amber,
                letterSpacing: 2.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        )));
  }
}
