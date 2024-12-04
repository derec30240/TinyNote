import 'package:flutter/material.dart';

import 'settings_service.dart';
import '../constants.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The `SettingsController`
/// uses the `SettingsService` to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  late ThemeMode _themeMode;
  ColorSeed _colorSelected = ColorSeed.baseColor;

  ThemeMode get themeMode => _themeMode;
  ColorSeed get colorSelected => _colorSelected;

  /// Load the user's settings from the `SettingsService` from a local database.
  /// The controller only knows it can load the settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }

  /// Update and persist the Theme Color based on the user's selection.
  Future<void> updateColorSelected(int? value) async {
    if (value == null) return;
    if (ColorSeed.values[value] == _colorSelected) return;

    _colorSelected = ColorSeed.values[value];

    notifyListeners();
    await _settingsService.updateColorSelected(ColorSeed.values[value]);
  }
}
