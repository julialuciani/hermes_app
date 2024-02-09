import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/content_box/utils/content_box_mixin.dart';

import '../../../utils/test_app_widget.dart';

class _MixinTestClass with ContentBoxMixin {}

void main() {
  final mixin = _MixinTestClass();

  testWidgets(
    "WHEN tap ContentBox THEN nothing should happen because nothing was GIVEN to onTap",
    (tester) async {
      int timesOnTapWasCalled = 0;

      await tester.pumpWidget(
        const TestAppWidget(
          child: ContentBox(
            child: Text(""),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(timesOnTapWasCalled, 0);

      await tester.tap(find.byKey(const Key("content_box_key")));

      expect(timesOnTapWasCalled, 0);
    },
  );

  testWidgets(
    "WHEN tap ContentBox THEN timesOnTapWasCalled should increase",
    (tester) async {
      int timesOnTapWasCalled = 0;

      await tester.pumpWidget(
        TestAppWidget(
          child: ContentBox(
            onTap: () {
              timesOnTapWasCalled++;
            },
            child: const Text(""),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(timesOnTapWasCalled, 0);

      await tester.tap(find.byKey(const Key("content_box_key")));

      expect(timesOnTapWasCalled, 1);
    },
  );

  test("GIVEN a null padding THEN default should be returned", () {
    //ARRANGE
    const expectedResult = EdgeInsets.all(16);
    const argument = null;

    //ACT
    final result = mixin.getPadding(argument);

    //ARRANGE
    expect(result, expectedResult);
  });

  test("GIVEN a padding THEN the given value should be returned", () {
    //ARRANGE
    const argument = EdgeInsets.all(8);
    const expectedResult = argument;

    //ACT
    final result = mixin.getPadding(argument);

    //ARRANGE
    expect(result, expectedResult);
  });

  test("GIVEN a borderColor THEN the given value should be returned", () {
    //ARRANGE
    const argument = Colors.white;
    const expectedResult = argument;

    //ACT
    final result = mixin.getBorderColor(argument);

    //ARRANGE
    expect(result, expectedResult);
  });

  test("GIVEN a null borderColor THEN the given value should be returned", () {
    //ARRANGE
    const argument = null;
    final expectedResult = AppColors.black;

    //ACT
    final result = mixin.getBorderColor(argument);

    //ARRANGE
    expect(result, expectedResult);
  });
}
