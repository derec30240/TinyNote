import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tiny_note/common/constants.dart';
import 'package:tiny_note/controllers/global_controller.dart';
import 'package:tiny_note/controllers/notes_controller.dart';

/// Displays the various settings that can be customized by the user.
class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final GlobalController globalController = Get.find<GlobalController>();
  final NotesController notesController = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => ListView(
              children: [
                Row(
                  children: [
                    const Text('Theme Mode: '),
                    const SizedBox(width: 20.0),
                    DropdownButton<ThemeMode>(
                      value: globalController.themeMode.value,
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
                      onChanged: globalController.updateThemeMode,
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
                            color: globalController.themeColor.value.color,
                          ),
                          const SizedBox(width: 10.0),
                          Text(globalController.themeColor.value.label),
                        ],
                      ),
                      itemBuilder: (context) {
                        return List.generate(
                          ColorSeed.values.length,
                          (index) {
                            ColorSeed currentColor = ColorSeed.values[index];
                            return PopupMenuItem(
                              value: index,
                              enabled: currentColor !=
                                  globalController.themeColor.value,
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      currentColor ==
                                              globalController.themeColor.value
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
                      onSelected: globalController.updateThemeColor,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Sort notes by: '),
                    const SizedBox(width: 20.0),
                    DropdownButton<String>(
                      value: globalController.noteSortOrder.value,
                      items: const [
                        DropdownMenuItem(
                          value: 'dateCreated',
                          child: Text('Date Created'),
                        ),
                        DropdownMenuItem(
                          value: 'dateLastEdited',
                          child: Text('Date Last Edited'),
                        ),
                      ],
                      onChanged: (sortOrder) {
                        globalController.updateNoteSortOrder(sortOrder);
                        notesController.sortNotes();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Sort notes in: '),
                    const SizedBox(width: 20.0),
                    DropdownButton<bool>(
                      value: globalController.noteSortAscending.value,
                      items: const [
                        DropdownMenuItem(
                          value: true,
                          child: Text('Ascending'),
                        ),
                        DropdownMenuItem(
                          value: false,
                          child: Text('Decending'),
                        ),
                      ],
                      onChanged: (sortAscending) {
                        globalController.updateNoteSortAscending(sortAscending);
                        notesController.sortNotes();
                      },
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
