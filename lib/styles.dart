import 'package:flutter/material.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.purple,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,

      disabledColor: Colors.grey[200],
      cardColor: isDarkTheme ? Colors.grey[700] : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.purple,
        elevation: 0.0,
      ),
    );

  }
}