import 'package:courier_rider/utils/colors.dart';
import 'package:flutter/material.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class TBottomNavigatorBarTheme {
  TBottomNavigatorBarTheme._();

  /* static var lightBottomNavigatorBarTheme = 
      const NavigationBarThemeData(surfaceTintColor: AppColors.white);

  static var darkBottomNavigatorBarTheme =
      const NavigationBarThemeData(surfaceTintColor: AppColors.dark); */

  static var lightBottomNavigationBarTheme = const NavigationBarThemeData(
      surfaceTintColor: AppColors.white, backgroundColor: AppColors.white);

  static var darkBottomNavigationBarTheme = const NavigationBarThemeData(
      surfaceTintColor: AppColors.dark, backgroundColor: AppColors.dark);
}
