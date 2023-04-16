import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  InputWidget({Key? key}) : super(key: key);

  String text = "";
  bool isTextObscure = false;
  String title = "";
  bool enabled = true;
  double marginLet = 0;
  double marginRight = 0;
  double marginTop = 0;
  double marginBottom = 0;
  TextInputAction action = TextInputAction.next;
  var controller = TextEditingController();

  InputWidget setEnabled(bool enabled) {
    this.enabled = enabled;

    return this;
  }

  InputWidget setAction(TextInputAction action) {
    this.action = action;
    return this;
  }

  InputWidget setIsTextObscure(bool isObscure) {
    isTextObscure = isObscure;
    return this;
  }

  InputWidget setTitle(String title) {
    this.title = title;
    return this;
  }

  InputWidget setText(String text) {
    this.text = text;
    controller.text = text;
    // _state.setState(() {
    //   controller.text = text;
    // });
    return this;
  }

  InputWidget setMarginLeft(double margin) {
    marginLet = margin;
    return this;
  }

  InputWidget setMarginRight(double margin) {
    marginRight = margin;
    return this;
  }

  InputWidget setMarginTop(double margin) {
    marginTop = margin;
    return this;
  }

  InputWidget setMarginBottom(double margin) {
    marginBottom = margin;
    return this;
  }

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        margin: EdgeInsets.fromLTRB(
            widget.marginLet, widget.marginTop, widget.marginRight, 0),
        child: Text(widget.title,
            style: const TextStyle(
              color: Colors.amber,
              letterSpacing: 2.0,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(
            widget.marginLet, 0, widget.marginRight, widget.marginBottom),
        child: TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          obscureText: widget.isTextObscure,
          keyboardType: TextInputType.emailAddress,
          textInputAction: widget.action,
          cursorColor: Colors.amber,
          onChanged: (text) {
            widget.text = text;
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder()),
        ),
      ),
    ]);
  }
}
