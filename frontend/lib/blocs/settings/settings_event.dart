import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.initial() = STInitial;
  const factory SettingsEvent.changeTheme({required ThemeMode themeMode}) = STChangeTheme;
  const factory SettingsEvent.healthCheck() = STHealthCheck;
}
