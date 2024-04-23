import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class TTextSelectionTheme {
  TTextSelectionTheme();

  static const lightTextSelectionTheme = TextSelectionThemeData(
    selectionHandleColor: AppColors.primary,
  );

  static const darkTextSelectionTheme =
      TextSelectionThemeData(selectionHandleColor: AppColors.primary);
}
