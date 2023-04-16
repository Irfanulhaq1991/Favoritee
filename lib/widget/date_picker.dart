import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'input_widget.dart';

class DateDialogueWidget extends StatefulWidget {
  DateDialogueWidget({Key? key}) : super(key: key);
  String _dob = DateFormat('MMMM dd, yyyy').format(DateTime.now());

  String get date {
    return _dob;
  }

  @override
  State<DateDialogueWidget> createState() => _DateDialogueWidgetState();
}

class _DateDialogueWidgetState extends State<DateDialogueWidget> {
  late InputWidget dobInput;

  @override
  void initState() {
    super.initState();
    dobInput = InputWidget()
        .setTitle("Date of Birth")
        .setEnabled(false)
        .setText(widget._dob)
        .setMarginTop(15.0);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _dialogBuilder(context);
      },
      child: dobInput,
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.9,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                widget._dob = DateFormat('MMMM dd, yyyy').format(newDateTime);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Okay'),
              onPressed: () {
                setState(() {
                  dobInput.setText(widget._dob);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
