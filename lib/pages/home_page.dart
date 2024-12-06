import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiny_note/controllers/global_controller.dart';
import 'package:tiny_note/pages/about_page.dart';

import 'settings_page.dart';
import 'about_page.dart';
import '../common/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiny Note'),
        actions: [
          Obx(() {
            // Show the Folder button only in the Notes screen
            return globalController.selectedHomeIndex.value == 0
                ? IconButton(
                    tooltip: 'Folders',
                    //TODO: Enable to create and manage folders.
                    onPressed: () {},
                    icon: const Icon(Icons.folder_outlined),
                  )
                : Container();
          }),
          IconButton(
            tooltip: 'Search',
            //TODO: Enable to search for notes and tasks.
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tiny Note',
                    style: textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Seize your every inspiration',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Get.to(() => SettingsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Get.to(() => AboutPage());
              },
            ),
          ],
        ),
      ),
      //TODO: Fill the body with meaningful things.
      body: const Placeholder(),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: globalController.selectedHomeIndex.value,
          onDestinationSelected: (index) {
            globalController.updateHomeIndex(index);
          },
          destinations: appBarDestinations,
        );
      }),
      floatingActionButton: FloatingActionButton(
        //TODO: Enable to create new note or task.
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.text_snippet_outlined),
    label: 'Notes',
    selectedIcon: Icon(Icons.text_snippet),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.check_box_outlined),
    label: 'Tasks',
    selectedIcon: Icon(Icons.check_box),
  ),
];
