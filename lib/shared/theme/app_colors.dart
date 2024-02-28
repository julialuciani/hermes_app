import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Orange/Yellow Tones
  static Color brightYellow = const Color(0xFFFAFF11);
  static const Color _yellowOrange2 = Color(0xFFF2D815);
  static const Color _yellowOrange3 = Color(0xFFE9B11A);
  static const Color _yellowOrange4 = Color(0xFFE1891E);
  static const Color _yellowOrange5 = Color(0xFFD86222);

  // Orange Tones
  static Color lightOrange = const Color(0xFFEC8F5D);
  static const Color _orange2 = Color(0xFFF08246);
  static const Color _orange3 = Color(0xFFF4752F);
  static const Color _orange4 = Color(0xFFF76717);
  static Color basicOrange = const Color(0xFFFB5A00);

  // Red Tones
  static Color lightRed = const Color(0xFFF0B4B4);
  static Color mediumRed = const Color(0xFFDF6262);
  static Color red = const Color(0xFFEA1616);
  static Color wine = const Color(0xFF781111);
  static Color darkWine = const Color(0xFF610A0A);

  // Blue Tones
  static Color skyBlue = const Color(0xFF83C2D7);
  static const Color _blue2 = Color(0xFF65A5CE);
  static Color lightBlue = const Color(0xFF4788C4);
  static const Color _blue4 = Color(0xFF296BBB);
  static Color darkBlue = const Color(0xFF0B4EB1);

  // Light Green Tones
  static const Color _lightGreen1 = Color(0xFF9CDD9A);
  static const Color _lightGreen2 = Color(0xFF88CD86);
  static const Color _lightGreen3 = Color(0xFF73BE71);
  static const Color _lightGreen4 = Color(0xFF5FAE5D);
  static const Color _lightGreen5 = Color(0xFF4A9E48);

  // Green/Dark Green Tones
  static const Color _darkGreen1 = Color(0xFF93D2B6);
  static const Color _darkGreen2 = Color(0xFF76B295);
  static const Color _darkGreen3 = Color(0xFF3D7251);
  static const Color _darkGreen4 = Color(0xFF205230);
  static Color darkGreen = const Color(0xFF04320E);

  //Purple Tones
  static const Color _purple1 = Color(0xFF9E81C4);
  static const Color _purple2 = Color(0xFF9061CD);
  static const Color _purple3 = Color(0xFF8241D5);
  static const Color _purple4 = Color(0xFF7320DE);
  static Color purple = const Color(0xFF6500E6);

  //Pink Tones
  static const Color _pink1 = Color(0xFFE493A9);
  static const Color _pink2 = Color(0xFFEA809D);
  static const Color _pink3 = Color(0xFFF06D91);
  static const Color _pink4 = Color(0xFFF65A84);
  static const Color _pink5 = Color(0xFFFC4778);

  //Dead Tones
  static Color lightGrey = const Color(0xFFE9E9E9);
  static Color mediumGrey = const Color(0xFFB39595);
  static Color grey = const Color(0xFFC4C4C4);
  static Color darkGrey = const Color(0xFF757575);
  static Color black = const Color(0xFF2E293A);

  static Color white = const Color(0xFFFFFFFF);

  static List<Color> allCategoriesColors = [
    //Yellow / Orange
    brightYellow,
    _yellowOrange2,
    _yellowOrange3,
    _yellowOrange4,
    _yellowOrange5,

    //Orange
    lightOrange, _orange2, _orange3, _orange4, basicOrange,

    //Red
    lightRed, mediumRed, red, wine, darkWine,

    //Blue
    skyBlue,
    _blue2,
    lightBlue,
    _blue4,
    darkBlue,

    //Light Green
    _lightGreen1,
    _lightGreen2,
    _lightGreen3,
    _lightGreen4,
    _lightGreen5,

    //Dark Green
    _darkGreen1,
    _darkGreen2,
    _darkGreen3,
    _darkGreen4,
    darkGreen,

    //Purple
    _purple1,
    _purple2,
    _purple3,
    _purple4,
    purple,

    //Pink
    _pink1,
    _pink2,
    _pink3,
    _pink4,
    _pink5,

    //Dead Tones
    lightGrey,
    mediumGrey,
    grey,
    darkGrey,
    black,
  ];

  static List<Color> colorsToHighlight = [
    red,
    brightYellow,
    _lightGreen5,
    darkGreen,
    skyBlue,
    darkBlue,
  ];
}
