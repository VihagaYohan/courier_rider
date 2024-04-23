import 'package:courier_rider/utils/utils.dart';
import 'package:flutter/material.dart';

class UISpacer extends StatelessWidget {
  final double? space;

  const UISpacer({super.key, this.space = Constants.smallSpace});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space);
  }
}
