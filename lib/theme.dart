import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightPrimaryColor = Colors.white;
  static final Color _lightOnPrimaryColor = Colors.grey[900] as Color;
  static const Color _lightTextColorPrimary = Colors.black;
  static final Color _lightSecondaryColor = Colors.grey[900] as Color;
  static const Color _appbarColorLight = Colors.white;

  static const Color _darkPrimaryColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.grey[100] as Color;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _darkSecondaryColor = Colors.grey[100] as Color;
  static const Color _appbarColorDark = Colors.black;

  static const TextStyle _lightHeadingText =
      TextStyle(color: _lightTextColorPrimary, fontFamily: "Rubik", fontSize: 32, fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyText =
      TextStyle(color: _lightTextColorPrimary, fontFamily: "Rubik", fontWeight: FontWeight.w500, fontSize: 16);

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeadingText,
    bodyLarge: _lightBodyText,
  );

  static final TextStyle _darkThemeHeadingTextStyle = _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyTextStyle = _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkThemeHeadingTextStyle,
    bodyLarge: _darkThemeBodyTextStyle,
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
      colorScheme: ColorScheme.light(
        primary: _lightTextColorPrimary,
        onPrimary: _lightOnPrimaryColor,
        secondary: _lightSecondaryColor,
      ),
      textTheme: _lightTextTheme,
      bottomAppBarTheme: const BottomAppBarTheme(color: _appbarColorLight));

  static final ThemeData darkTheme = ThemeData(
    inputDecorationTheme: _inputDecorationTheme,
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(color: _appbarColorDark, iconTheme: IconThemeData(color: _darkOnPrimaryColor)),
    iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    colorScheme: ColorScheme.dark(
      primary: _darkTextColorPrimary,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
    ),
    textTheme: _darkTextTheme,
    bottomAppBarTheme: const BottomAppBarTheme(color: _appbarColorDark),
  );
}
