import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiny_note/common/constants.dart';

class GlobalController extends GetxController {
  static GlobalController instance = Get.find();

  var themeMode = ThemeMode.system.obs;
  var themeColor = ColorSeed.baseColor.obs;
  var selectedHomeIndex = 0.obs;
  var noteSortOrder = 'dateCreated'.obs;
  var noteSortAscending = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    themeMode.value = ThemeMode.values
        .byName(prefs.getString('themeMode') ?? ThemeMode.system.name);
    themeColor.value = ColorSeed.values.firstWhere(
        (seed) => seed.label == prefs.getString('themeColor'),
        orElse: () => ColorSeed.baseColor);
    selectedHomeIndex.value = prefs.getInt('selectedHomeIndex') ?? 0;
    noteSortOrder.value = prefs.getString('noteSortOrder') ?? 'dateCreated';
    noteSortAscending.value = prefs.getBool('noteSortAscending') ?? false;
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('themeMode', themeMode.value.name);
    await prefs.setString('themeColor', themeColor.value.label);
    await prefs.setInt('selectedHomeIndex', selectedHomeIndex.value);
    await prefs.setString('noteSortOrder', noteSortOrder.value);
    await prefs.setBool('noteSortAscending', noteSortAscending.value);
  }

  void updateThemeMode(ThemeMode? newThemeMode) {
    if (newThemeMode == null) return;
    if (newThemeMode == themeMode.value) return;

    themeMode.value = newThemeMode;
    _saveSettings();
  }

  void updateThemeColor(int? value) {
    if (value == null) return;
    if (ColorSeed.values[value] == themeColor.value) return;

    themeColor.value = ColorSeed.values[value];
    _saveSettings();
  }

  void updateSelectedHomeIndex(int? newHomeindex) {
    if (newHomeindex == null) return;
    if (newHomeindex == selectedHomeIndex.value) return;

    selectedHomeIndex.value = newHomeindex;
    _saveSettings();
  }

  void updateNoteSortOrder(String? newOrder) {
    if (newOrder == null) return;
    if (newOrder == noteSortOrder.value) return;

    noteSortOrder.value = newOrder;
    _saveSettings();
  }

  void updateNoteSortAscending(bool? newAscending) {
    if (newAscending == null) return;
    if (newAscending == noteSortAscending.value) return;

    noteSortAscending.value = newAscending;
    _saveSettings();
  }
}
