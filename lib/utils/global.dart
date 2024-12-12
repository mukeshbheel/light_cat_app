import 'dart:math';

import 'package:flutter/material.dart';

String getRandomColorString() {
  final random = Random();
  // Generate random values for R, G, and B
  int red = random.nextInt(256); // Range: 0 to 255
  int green = random.nextInt(256);
  int blue = random.nextInt(256);

  // Convert RGB to a hexadecimal color string
  String colorString = '#${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}';

  return colorString;
}

Color colorFromString(String colorString) {
  return Color(int.parse(colorString.substring(1, 7), radix: 16) + 0xFF000000);
}