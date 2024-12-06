import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/common/constants.dart';

class GlobalController extends GetxController {
  static GlobalController instance = Get.find();

  var themeMode = ThemeMode.system.obs;
  var themeColor = ColorSeed.baseColor.obs;

  void updateThemeMode(ThemeMode? newThemeMode) {
    if (newThemeMode == null) return;
    if (newThemeMode == themeMode.value) return;

    themeMode.value = newThemeMode;
    Get.changeThemeMode(newThemeMode);
  }

  void updateThemeColor(int? value) {
    if (value == null) return;
    if (ColorSeed.values[value] == themeColor.value) return;

    themeColor.value = ColorSeed.values[value];
    Get.changeTheme(ThemeData(colorSchemeSeed: themeColor.value.color));
  }
}
