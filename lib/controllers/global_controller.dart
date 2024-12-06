import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/common/constants.dart';

class GlobalController extends GetxController {
  static GlobalController instance = Get.find();

  var themeMode = ThemeMode.system.obs;
  var themeColor = ColorSeed.baseColor.obs;

  var selectedHomeIndex = 0.obs;

  void updateThemeMode(ThemeMode? newThemeMode) {
    if (newThemeMode == null) return;
    if (newThemeMode == themeMode.value) return;

    themeMode.value = newThemeMode;
  }

  void updateThemeColor(int? value) {
    if (value == null) return;
    if (ColorSeed.values[value] == themeColor.value) return;

    themeColor.value = ColorSeed.values[value];
  }

  void updateHomeIndex(int? newHomeindex) {
    if (newHomeindex == null) return;
    if (newHomeindex == selectedHomeIndex.value) return;

    selectedHomeIndex.value = newHomeindex;
  }
}
