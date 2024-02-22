import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class IconUtils {
  static IconData getIconByName(String iconName) {
    switch (iconName) {
      case "food":
        return Ionicons.fast_food_outline;
      case "bus":
        return Ionicons.bus;
      case "home":
        return Ionicons.home;
      case "renda_fixa":
        return Ionicons.bar_chart;
      case "salario":
        return Ionicons.cash;
      case "barbell":
        return Icons.fitness_center;
      case "shopping_cart":
        return Ionicons.cart_outline;
      case "eletronics":
        return Ionicons.desktop_outline;
      default:
        return Icons.abc;
    }
  }
}
