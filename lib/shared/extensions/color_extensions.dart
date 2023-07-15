import 'package:flutter/material.dart';

extension ColorExtension on Color {
  int colorToInt() => (alpha << 24) | (red << 16) | (green << 8) | blue;
}

extension IntToColor on int {
  Color intToColor() {
    return Color.fromARGB(
      (this >> 24) & 0xFF,
      (this >> 16) & 0xFF,
      (this >> 8) & 0xFF,
      this & 0xFF,
    );
  }
}
