import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class TAppBarTheme {
  TAppBarTheme();

  static const lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: AppColors.dark,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'Poppins'));

  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.white, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white));
}
