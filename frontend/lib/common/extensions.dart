import 'package:flutter/material.dart';

extension ThemeModeExtensions on ThemeMode {
  static ThemeMode ofSystem(BuildContext context) {
    switch (MediaQuery.platformBrightnessOf(context)) {
      case Brightness.dark:
        return ThemeMode.dark;
      case Brightness.light:
        return ThemeMode.light;
    }
  }

  bool value(BuildContext context) {
    if (this == ThemeMode.system) {
      switch (ThemeModeExtensions.ofSystem(context)) {
        case ThemeMode.system:
          throw UnsupportedError('System Theme Has No Value');
        case ThemeMode.light:
          return false;
        case ThemeMode.dark:
          return true;
      }
    } else {
      switch (this) {
        case ThemeMode.system:
          throw UnsupportedError('System Theme Has No Value');
        case ThemeMode.light:
          return false;
        case ThemeMode.dark:
          return true;
      }
    }
  }

  ThemeMode inverse(BuildContext context) {
    if (this == ThemeMode.system) {
      switch (ThemeModeExtensions.ofSystem(context)) {
        case ThemeMode.system:
          throw UnsupportedError('System Theme Has No Value');
        case ThemeMode.light:
          return ThemeMode.dark;
        case ThemeMode.dark:
          return ThemeMode.light;
      }
    } else {
      switch (this) {
        case ThemeMode.system:
          throw UnsupportedError('System Theme Has No Value');
        case ThemeMode.light:
          return ThemeMode.dark;
        case ThemeMode.dark:
          return ThemeMode.light;
      }
    }
  }

  IconData get icon {
    switch (this) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }
}
