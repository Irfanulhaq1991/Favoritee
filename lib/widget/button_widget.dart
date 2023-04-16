import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget({Key? key}) : super(key: key);
  Function() function = () {};

  String title = "";
  bool isEnabled = false;

  ButtonWidget setTitle(String title) {
    this.title = title;
    return this;
  }

  ButtonWidget setCallBack(Function() function) {
    this.function = function;
    return this;
  }

  ButtonWidget enable(bool isEnabled) {
    this.isEnabled = isEnabled;
    return this;
  }

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 0.0),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: TextButton(
                  onPressed: widget.function ,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  child: Text(widget.title,
                      style: const TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ))
          ],
        ));
  }
}
