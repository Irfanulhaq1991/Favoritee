import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController _controller = TextEditingController();
  bool enable = false;
  String title = "Edit";
  InputBorder border = InputBorder.none;

  @override
  void initState() {
    _controller.text = "Hello";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enabled: enable,
              showCursor: true,
              controller: _controller,
              autofocus: true,
              decoration:  InputDecoration(border: InputBorder.none,
                filled: enable,
                fillColor: Colors.grey,


              ),
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() {

                  enable = !enable;
                  title = enable? "Done": "Edit";
                  border = border != InputBorder.none
                      ? InputBorder.none
                      : const OutlineInputBorder();
                });
              },
              child: Text(title))
        ],
      ),
    ));
  }
}
