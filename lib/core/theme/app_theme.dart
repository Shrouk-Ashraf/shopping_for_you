import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/theme/custom_themes/app_bar_theme.dart';
import 'package:four_you_ecommerce/core/theme/custom_themes/check_box_theme.dart';
import 'package:four_you_ecommerce/core/theme/custom_themes/custom_text_theme.dart';
import 'package:four_you_ecommerce/core/theme/custom_themes/elevated_button_theme.dart';
import 'package:four_you_ecommerce/core/theme/custom_themes/text_field_theme.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.lightBackgroundColor,
  fontFamily: 'Poppins',
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: CustomTextTheme.lightTextTheme,
  elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
  appBarTheme: CustomAppBarTheme.lightAppBarTheme,
  checkboxTheme: CustomCheckBoxTheme.lightCheckBoxTheme,
  inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme,
);

ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: Colors.black,
  fontFamily: 'Poppins',
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: CustomTextTheme.darkTextTheme,
  elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
  appBarTheme: CustomAppBarTheme.darkAppBarTheme,
  checkboxTheme: CustomCheckBoxTheme.darkCheckBoxTheme,
  inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme,
);
