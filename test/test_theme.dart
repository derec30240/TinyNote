import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ColorSeed {
  baseColor('Base Color', Color(0xff15559a)),
  pink('Pink', Colors.pink),
  deepOrange('Deep Orange', Colors.deepOrange),
  orange('Orange', Colors.orange),
  yellow('Yellow', Colors.yellow),
  green('Green', Colors.green),
  teal('Teal', Colors.teal),
  blue('Blue', Colors.blue),
  indigo('Indigo', Colors.indigo);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

class MyController extends GetxController {
  static MyController instance = Get.find();

  var themeMode = ThemeMode.system.obs;
  var themeColor = ColorSeed.baseColor.obs;

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
}

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MyController myController = Get.put(MyController());

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      colorSchemeSeed: myController.themeColor.value.color,
      useMaterial3: true,
      brightness: brightness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: "Test Theme",
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          themeMode: myController.themeMode.value,
          home: MyHome(),
        ));
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onPrimary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Theme'),
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
                Get.to(() => MySettings());
              },
            ),
          ],
        ),
      ),
      body: const Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class MySettings extends StatelessWidget {
  MySettings({super.key});

  final MyController myController = Get.find<MyController>();

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
            Obx(() => Row(
                  children: [
                    const Text('Theme Mode: '),
                    const SizedBox(width: 20.0),
                    DropdownButton<ThemeMode>(
                      value: myController.themeMode.value,
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
                      onChanged: myController.updateThemeMode,
                    ),
                  ],
                )),
            Obx(() => Row(
                  children: [
                    const Text('Theme Color: '),
                    const SizedBox(width: 20.0),
                    PopupMenuButton(
                      icon: Row(
                        children: [
                          Icon(
                            Icons.palette_outlined,
                            color: myController.themeColor.value.color,
                          ),
                          const SizedBox(width: 10.0),
                          Text(myController.themeColor.value.label),
                        ],
                      ),
                      itemBuilder: (context) {
                        return List.generate(
                          ColorSeed.values.length,
                          (index) {
                            ColorSeed currentColor = ColorSeed.values[index];
                            return PopupMenuItem(
                              value: index,
                              enabled:
                                  currentColor != myController.themeColor.value,
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      currentColor ==
                                              myController.themeColor.value
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
                      onSelected: myController.updateThemeColor,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
