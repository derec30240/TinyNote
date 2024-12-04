import 'package:flutter/material.dart';

import '../constants.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  // Loads the user's preffered settings from local storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  //TODO: Use the shared_preference package to persist settings locally.

  // Persist the user's preffered settings to local storage.
  Future<void> updateThemeMode(ThemeMode theme) async {}
  Future<void> updateColorSelected(ColorSeed color) async {}
}
