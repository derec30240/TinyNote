import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/global_controller.dart';
import 'pages/home_page.dart';

/// The Widget that configures the application.
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: globalController.themeColor.value.color,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: globalController.themeColor.value.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: globalController.themeMode.value,
      color: globalController.themeColor.value.color,
      home: HomePage(),
    );
  }
}
