import 'package:favoritee/widget/button_widget.dart';
import 'package:favoritee/widget/input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../data/user/local/UserDao.dart';
import '../widget/Toast.dart';
import '../widget/date_picker.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late InputWidget emailInput;
  late InputWidget dobInput;
  late ButtonWidget buttonWidget;
  late DateDialogueWidget dateDialogueWidget;
  late UserDao userDTO;

  @override
  void initState() {
    super.initState();
    userDTO = UserDao(() {
      // logic on init
    });
    emailInput =
        InputWidget().setTitle("Email").setAction(TextInputAction.done);
    dateDialogueWidget = DateDialogueWidget();
    buttonWidget = ButtonWidget().setTitle("Recover").setCallBack(() {
      if (emailInput.text.isEmpty) {
        showToast(context, "Email is required");
        return;
      }
      recoverPassword(emailInput.text, dateDialogueWidget.date);
    });
  }

  void recoverPassword(String email, String dob) async {
    List<UserDomainModel> userDomains = await userDTO.getFromDb();

    if (userDomains.first.email == email &&
        userDomains.first.dob == dob) {
      showToast(context, "Your Password: ${userDomains.first.password}");
      Navigator.of(context).pop();
    } else {
      showToast(context, "No account found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: LogoAndTitle(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Form(
                  child: Column(
                    children: [emailInput, dateDialogueWidget, buttonWidget],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class LogoAndTitle extends StatelessWidget {
  const LogoAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/lock.png'),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: const Text("Recover Password",
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 4,
                  fontSize: 22,
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                )))
      ],
    ));
  }
}
