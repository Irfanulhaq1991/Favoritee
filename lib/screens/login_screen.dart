import 'package:favoritee/screens/personal_details_screen.dart';
import 'package:favoritee/screens/sign_up_screen.dart';
import 'package:favoritee/widget/Toast.dart';
import 'package:favoritee/widget/input_widget.dart';
import 'package:flutter/material.dart';


import '../data/user/local/UserDao.dart';
import '../widget/button_widget.dart';
import 'forgort_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: LogoAndTitle()),
          Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: LoginForm(),
          ),
          SignUp()
        ],
      ),
    )));
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
            child: const Text("Login Now",
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

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SingUpScreen()));
            },
            child: const Text("Sign Up",
                style: TextStyle(
                  color: Colors.amber,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ))),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  InputWidget? userNameInput;

  InputWidget? passwordInput;

  ButtonWidget? buttonWidget;
  late UserDao userDTO;

  @override
  void initState() {
    super.initState();
    userNameInput = InputWidget().setTitle("Email").setMarginTop(20.0);

    passwordInput = InputWidget()
        .setTitle("Password")
        .setMarginTop(20.0)
        .setIsTextObscure(true)
        .setAction(TextInputAction.done);

    userDTO = UserDao(() {
      // logic on init
    });

    buttonWidget = ButtonWidget().setTitle("Login").setCallBack(() {
      if (userNameInput!.text.isEmpty) {
        showToast(context, "Username is required");
        return;
      }
      if (passwordInput!.text.isEmpty) {
        showToast(context, "Password is required");
        return;
      }

      // login logic
      doLogin(userNameInput!.text, passwordInput!.text);
    });
  }

  void doLogin(String userName, String password) async {
    List<UserDomainModel> userDomains = await userDTO.getFromDb();
    if (userDomains.isEmpty) {
      if (context.mounted) {
        showToast(context, "Login failed: Please register before login");
      }
      return;
    }
    if (userDomains.first.email == userName &&
        userDomains.first.password == password) {
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PersonalDetailsScreen()));

        showToast(context, "Login is successful");
      }
    } else {
      if (context.mounted) {
        showToast(context, "Login failed: Invalid credentials");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        userNameInput!,
        passwordInput!,
        const ForgotPassword(),
        buttonWidget!
      ],
    ));
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
        child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen()));
            },
            child: const Text("Forgot password?",
                style: TextStyle(
                  color: Colors.amber,
                  letterSpacing: 2.0,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ));
  }
}
