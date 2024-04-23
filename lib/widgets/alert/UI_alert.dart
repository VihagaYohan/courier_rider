import 'package:courier_rider/widgets/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:awesome_alert/awesome_alert.dart';

class UIAlert extends StatelessWidget {
  const UIAlert(
      {super.key, required this.title, required this.message, this.onConfirm});

  final String title;
  final String message;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: UITextView(text: title),
      content: UITextView(text: message),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: UITextView(text: "Cancel")),
        TextButton(onPressed: onConfirm ?? () {}, child: UITextView(text: "OK"))
      ],
    );
  }
}
