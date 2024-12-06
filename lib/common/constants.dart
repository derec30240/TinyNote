import 'package:flutter/material.dart';

const double narrowScreenWidthThreshold = 450;

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

enum ScreenSelected {
  screen1(0),
  screen2(1);

  const ScreenSelected(this.value);
  final int value;
}
