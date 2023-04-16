import 'package:favoritee/widget/Toast.dart';
import 'package:favoritee/widget/button_widget.dart';
import 'package:favoritee/widget/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../data/user/local/UserDao.dart';
import '../widget/date_picker.dart';
import '../widget/heading_widget.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  InputWidget? firstNameInput;
  InputWidget? lastNameInput;

  InputWidget? educationInput;

  InputWidget? dobInput;

  InputWidget? emailInput;

  InputWidget? passwordInput;

  late ButtonWidget buttonWidget;
  late DateDialogueWidget dateDialogueWidget;

  late Heading heading;
  late UserDao userDTO;

  @override
  void initState() {
    super.initState();
    heading = Heading();
    firstNameInput = InputWidget().setTitle("First Name").setMarginTop(20.0);
    lastNameInput = InputWidget().setTitle("Last Name").setMarginTop(20.0);
    educationInput = InputWidget().setTitle("Education").setMarginTop(20.0);
    dobInput = InputWidget().setTitle("DOB").setMarginTop(20.0);
    emailInput = InputWidget().setTitle("Email").setMarginTop(20.0);
    passwordInput = InputWidget()
        .setTitle("password")
        .setMarginTop(20.0)
        .setIsTextObscure(true)
        .setAction(TextInputAction.done);
    userDTO = UserDao(() {
      // enable the singup button
      buttonWidget.enable(true);
    });
    dateDialogueWidget = DateDialogueWidget();

    buttonWidget = ButtonWidget().setTitle("Sign Up").setCallBack(() {
      print("singup clicked");
      if (heading!.xFile == null) {
        showToast(context, "Please select Image");
        return;
      }
      if (firstNameInput!.text.isEmpty) {
        showToast(context, "First name is required");
        return;
      }
      if (lastNameInput!.text.isEmpty) {
        showToast(context, "Last name is required");
        return;
      }
      if (emailInput!.text.isEmpty) {
        showToast(context, "Email is required");
        return;
      }
      if (passwordInput!.text.isEmpty) {
        showToast(context, "Password is required");
        return;
      }

      if (educationInput!.text.isEmpty) {
        showToast(context, "education is required");
        return;
      }
      UserDomainModel userDomainModel = UserDomainModel(
          id: 0,
          firstName: firstNameInput!.text,
          lastName: lastNameInput!.text,
          email: emailInput!.text,
          dob: dateDialogueWidget!.date,
          password: passwordInput!.text,
          education: educationInput!.text,
          imagePath: heading.xFile!.path);
      doRegister(userDomainModel);
    });
  }

  void doRegister(UserDomainModel userDomainModel) async {
    int id = await userDTO.saveToDb(userDomainModel);

    if (id == userDomainModel.id) {
      if (context.mounted) {
        showToast(context, "Signed Up successfully");
        Navigator.of(context).pop();

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                child: heading,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: Form(
                    child: Column(
                  children: [
                    dateDialogueWidget,
                    firstNameInput!,
                    lastNameInput!,
                    educationInput!,
                    emailInput!,
                    passwordInput!,
                    buttonWidget!
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
