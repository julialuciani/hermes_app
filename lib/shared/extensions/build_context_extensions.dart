import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  /// [screenWidth] will return the maximum width of the screen
  double get screenWidth => MediaQuery.of(this).size.width;

  /// [screenHeight] will return the maximum height of the screen
  double get screenHeight => MediaQuery.of(this).size.height;

  /// [viewInsetsBottomPadding] will return the offset from the bottom of the screen
  /// this is very useful to be used on TextFields inside modal widgets
  double get viewInsetsBottomPadding => MediaQuery.of(this).viewInsets.bottom;
}
