import 'package:flutter/material.dart';

final ThemeData materialLight = ThemeData(
  fontFamily: 'varela',
  useMaterial3: false,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.deepPurple,
    secondary: Colors.grey.shade200,
    tertiary: Colors.lightBlue,
  ),
);

final ThemeData materialDark = ThemeData(
  fontFamily: 'varela',
  useMaterial3: false,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.amber,
    secondary: Colors.grey.shade800,
    tertiary: Colors.indigo,
  ),
);

extension BooperColorScheme on ColorScheme {
  Color get inverseTextColor {
    switch (brightness) {
      case Brightness.dark:
        return Colors.black;
      case Brightness.light:
        return Colors.white;
    }
  }
}
