import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

// provider
import 'package:courier_rider/provider/providers.dart';

class UIAvatar extends StatefulWidget {
  final String name;
  final double? width;
  final double? height;
  final double? fontSize;

  const UIAvatar(
      {super.key,
      required this.name,
      this.width = 60,
      this.height = 60,
      this.fontSize = 20});

  @override
  State<UIAvatar> createState() => _UIAvatarState();
}

class _UIAvatarState extends State<UIAvatar> {
  @override
  void initState() {
    super.initState();
  }

  // get name initials
  String getInitials(String name) {
    List<String> words = name.split(' ');
    if (words.length >= 2) {
      return "${words[0][0]}${words[1][0]}";
    } else {
      return words[0][0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(colors: <Color>[AppColors.primary, Colors.green])),
      child: Center(
        child: UITextView(
          text: getInitials(widget.name),
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: widget.fontSize, color: AppColors.white),
        ),
      ),
    );
  }
}
