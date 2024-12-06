import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/global_controller.dart';
import 'pages/home_page.dart';

/// The Widget that configures the application.
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalController globalController = Get.put(GlobalController());

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      colorSchemeSeed: globalController.themeColor.value.color,
      useMaterial3: true,
      brightness: brightness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'Tiny Note',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          themeMode: globalController.themeMode.value,
          home: HomePage(),
        ));
  }
}
