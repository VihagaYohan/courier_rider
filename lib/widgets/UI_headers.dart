import 'package:courier_rider/utils/utils.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

class UIHeader extends StatelessWidget {
  final String title;
  final bool? isSubtitle;

  const UIHeader({super.key, required this.title, this.isSubtitle = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: Constants.smallSpace),
        UITextView(
          text: title,
          textAlign: TextAlign.left,
          textStyle: isSubtitle == true
              ? Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12)
              : Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
        ),
        const SizedBox(height: Constants.smallSpace),
      ],
    );
  }
}
