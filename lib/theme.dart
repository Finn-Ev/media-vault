import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightPrimaryColor = Colors.white;
  static final Color _lightOnPrimaryColor = Colors.grey[900] as Color;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.white;

  static const Color _darkPrimaryColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.grey[50] as Color;
  static const Color _darkTextColorPrimary = Colors.white;
  static const Color _appbarColorDark = Colors.black;

  static const Color _accentColorDark = Color.fromRGBO(74, 217, 217, 1);

  static const TextStyle _lightHeadingText = TextStyle(color: _lightTextColorPrimary, fontFamily: "Rubik", fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyText = TextStyle(color: _lightTextColorPrimary, fontFamily: "Rubik", fontWeight: FontWeight.w500, fontSize: 16);

  static const TextTheme _lightTextTheme = TextTheme(
    headline1: _lightHeadingText,
    bodyText1: _lightBodyText,
  );

  static final TextStyle _darkThemeHeadingTextStyle = _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyTextStyle = _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkThemeHeadingTextStyle,
    bodyText1: _darkThemeBodyTextStyle,
  );

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: Colors.white),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
      inputDecorationTheme: _inputDecorationTheme,
      scaffoldBackgroundColor: _lightPrimaryColor,
      appBarTheme: AppBarTheme(color: _appbarColorLight, iconTheme: IconThemeData(color: _lightOnPrimaryColor)),
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      bottomAppBarColor: _appbarColorLight,
      colorScheme: ColorScheme.light(primary: _lightPrimaryColor, onPrimary: _lightOnPrimaryColor, secondary: _accentColorDark),
      textTheme: _lightTextTheme);

  static final ThemeData darkTheme = ThemeData(
    inputDecorationTheme: _inputDecorationTheme,
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(color: _appbarColorDark, iconTheme: IconThemeData(color: _darkOnPrimaryColor)),
    iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    bottomAppBarColor: _appbarColorDark,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _accentColorDark,
      onPrimary: _darkOnPrimaryColor,
    ),
    textTheme: _darkTextTheme,
  );
}
