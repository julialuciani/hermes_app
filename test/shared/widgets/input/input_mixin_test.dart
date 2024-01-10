import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/input/utils/input_mixin.dart';

class _MixinTestClass with InputMixin {}

void main() {
  final sut = _MixinTestClass();

  test(
    "WHEN get input fill color with input enabled THEN ensure return is expected",
    () {
      final expectedResult = AppColors.lightGrey;

      final result = sut.getInputFillColor(true);

      expect(result, expectedResult);
    },
  );
  test(
    "WHEN get input fill color with input not enabled THEN ensure return is expected",
    () {
      final expectedResult = AppColors.grey;

      final result = sut.getInputFillColor(false);

      expect(result, expectedResult);
    },
  );
  test(
    "WHEN get border side with text null THEN ensure return is expected",
    () {
      const expectedResult = BorderSide.none;

      final result = sut.getBorderSideByErrorText(null);

      expect(result, expectedResult);
    },
  );
  test(
    "WHEN get border side with some text THEN ensure return is expected",
    () {
      final expectedResult = BorderSide(color: AppColors.red);

      final result = sut.getBorderSideByErrorText("any_text");

      expect(result, expectedResult);
    },
  );
}
