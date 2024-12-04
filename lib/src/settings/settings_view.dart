import 'package:flutter/material.dart';

import 'settings_controller.dart';
import '../constants.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, `SettingsController` is updated and Widgets
/// that listen to `SettingsController` are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    required this.controller,
  });

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Glue the `SettingsController` to the theme selection in the
            // DropdownButton.
            //
            // When a user selects a theme from the dropdown list, the
            // `SettingsController` is updated, which rebuilds the
            // `MaterialApp`.
            Row(
              children: [
                const Text('Theme Mode: '),
                const SizedBox(width: 20.0),
                DropdownButton<ThemeMode>(
                  value: controller.themeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark Theme'),
                    )
                  ],
                  onChanged: controller.updateThemeMode,
                ),
              ],
            ),
            Row(
              children: [
                const Text('Theme Color: '),
                const SizedBox(width: 20.0),
                PopupMenuButton(
                  icon: Row(
                    children: [
                      Icon(
                        Icons.palette_outlined,
                        color: controller.colorSelected.color,
                      ),
                      const SizedBox(width: 10.0),
                      Text(controller.colorSelected.label),
                    ],
                  ),
                  itemBuilder: (context) {
                    return List.generate(
                      ColorSeed.values.length,
                      (index) {
                        ColorSeed currentColor = ColorSeed.values[index];
                        return PopupMenuItem(
                          value: index,
                          enabled: currentColor != controller.colorSelected,
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  currentColor == controller.colorSelected
                                      ? Icons.color_lens
                                      : Icons.color_lens_outlined,
                                  color: currentColor.color,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(currentColor.label),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  onSelected: controller.updateColorSelected,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
