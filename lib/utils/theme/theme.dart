import 'package:courier_rider/utils/colors.dart';
import 'package:courier_rider/utils/theme/custom_themes/appbar_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/chip_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/outlined_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/text_button.dart';
import 'package:courier_rider/utils/theme/custom_themes/text_field.dart';
import 'package:courier_rider/utils/theme/custom_themes/text_selection_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/text_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/bottom_navigation_bar_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/date_picker_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/time_picker_theme.dart';
import 'package:courier_rider/utils/theme/custom_themes/fab_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckboxTheme,
    chipTheme: TChipTheme.lightChipTheme,
    outlinedButtonTheme: TOutlineButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.lightInputDecorationTheme,
    navigationBarTheme: TBottomNavigatorBarTheme.lightBottomNavigationBarTheme,
    textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
    textSelectionTheme: TTextSelectionTheme.lightTextSelectionTheme,
    datePickerTheme: TDatePickerTheme.lightDatePickerTheme,
    timePickerTheme: TTimePickerTheme.lightTimePickerTheme,
    floatingActionButtonTheme: TFabButtonTheme.lightFabButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.dark,
      textTheme: TTextTheme.darkTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      checkboxTheme: TCheckBoxTheme.darkCheckboxTheme,
      chipTheme: TChipTheme.darkChipTheme,
      outlinedButtonTheme: TOutlineButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: TTextFieldTheme.darkInputDecorationTheme,
      navigationBarTheme: TBottomNavigatorBarTheme.darkBottomNavigationBarTheme,
      textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
      textSelectionTheme: TTextSelectionTheme.darkTextSelectionTheme,
      datePickerTheme: TDatePickerTheme.darkDatePickerTheme,
      timePickerTheme: TTimePickerTheme.darkTimePickerTheme,
      floatingActionButtonTheme: TFabButtonTheme.darkFabButtonTheme);
}
