import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/constants.dart';

class GlobalController extends GetxController {
  static GlobalController instance = Get.find();

  var themeMode = ThemeMode.system.obs;
  var themeColor = ColorSeed.baseColor.obs;
  var selectedHomeIndex = 0.obs;
  var noteSortOrder = 'dateCreated'.obs;
  var noteSortAscending = false.obs;

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

  void updateSelectedHomeIndex(int? newHomeindex) {
    if (newHomeindex == null) return;
    if (newHomeindex == selectedHomeIndex.value) return;

    selectedHomeIndex.value = newHomeindex;
  }

  void updateNoteSortOrder(String? newOrder) {
    if (newOrder == null) return;
    if (newOrder == noteSortOrder.value) return;

    noteSortOrder.value = newOrder;
  }

  void updateNoteSortAscending(bool? newAscending) {
    if (newAscending == null) return;
    if (newAscending == noteSortAscending.value) return;

    noteSortAscending.value = newAscending;
  }
}
