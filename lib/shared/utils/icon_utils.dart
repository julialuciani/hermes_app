import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_icons.dart';

class IconUtils {
  static final Map<IconData, String> _iconDataAndNames = {
    AppIcons.fastFood: 'food',
    AppIcons.bus: 'bus',
    AppIcons.car: 'car',
    AppIcons.carSport: 'car_sport',
    AppIcons.airplane: 'airplane',
    AppIcons.bicycle: 'bicycle',
    AppIcons.house: 'home',
    AppIcons.chartBar: 'renda_fixa',
    AppIcons.cash: 'salario',
    AppIcons.fitness: 'barbell',
    AppIcons.cart: 'shopping_cart',
    AppIcons.desktop: 'electronics',
    AppIcons.heart: 'heart',
    AppIcons.pizza: 'pizza',
    AppIcons.medkit: 'medkit',
    AppIcons.restaurant: 'restaurant',
    AppIcons.cake: 'cake',
    AppIcons.drinks: 'drinks',
    AppIcons.liquor: 'liquor',
    AppIcons.truck: 'truck',
    AppIcons.train: 'train',
    AppIcons.taxi: 'taxi',
    AppIcons.bike: 'bike',
    AppIcons.bed: 'bed',
    AppIcons.ac: 'ac',
    AppIcons.lighting: 'lighting',
    AppIcons.sensors: 'sensors',
    AppIcons.water: 'water',
    AppIcons.receipt: 'receipt',
    AppIcons.neurology: 'neurology',
    AppIcons.dentist: 'dentist',
    AppIcons.pills: 'pills',
    AppIcons.syringe: 'syringe',
    AppIcons.dollarSack: 'dollarSack',
    AppIcons.chartPie: 'chartPie',
    AppIcons.chartLine: 'chartLine',
    AppIcons.bitcoin: 'bitcoin',
    AppIcons.savings: 'savings',
    AppIcons.videoGame: 'videoGame',
    AppIcons.mobile: 'mobile',
    AppIcons.tv: 'tv',
    AppIcons.headset: 'headset',
    AppIcons.mouse: 'mouse',
  };

  static IconData getIconByName(String iconName) {
    IconData? icon;
    _iconDataAndNames.forEach((key, value) {
      if (value == iconName) {
        icon = key;
      }
    });
    return icon ?? Icons.abc;
  }

  static String getIconNameByIcon(IconData icon) {
    return _iconDataAndNames[icon] ?? '';
  }
}
