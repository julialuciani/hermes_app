import 'package:flutter/material.dart';

class IntToColor {
  static Color execute(int alpha, int red, int green, int blue) {
    return Color.fromARGB(alpha, red, green, blue);
  }
}
