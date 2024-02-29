import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default('') String apiVersion,
  }) = _SettingsState;
}
