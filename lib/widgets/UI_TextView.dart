import 'package:flutter/material.dart';

class UITextView extends StatelessWidget {
  const UITextView(
      {super.key,
      required this.text,
      this.textStyle,
      this.textAlign = TextAlign.center,
      this.softWrap = true,
      this.maxLines = 2});

  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final bool? softWrap;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
