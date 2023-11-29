import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';

import '../../../utils/test_app_widget.dart';

void main() {
  testWidgets(
      'WHEN call button.enabled THEN find it true as it was not passed another then the default value',
      (testers) async {
    final button = DefaultButton(onPressed: () {}, title: const Text(''));

    expect(button.enabled, true);
  });

  testWidgets(
      'WHEN call button.loading THEN find it false as it was not passed another then the default value',
      (testers) async {
    final button = DefaultButton(onPressed: () {}, title: const Text(''));

    expect(button.isLoading, false);
  });

  testWidgets('WHEN enabled is false THEN button background color is grey',
      (tester) async {
    await tester.pumpWidget(
      TestAppWidget(
        child: DefaultButton(
          onPressed: () {},
          title: const Text(''),
          enabled: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final button =
        tester.widget<ElevatedButton>(find.byKey(const Key('DefaultButton')));
    final color = button.style!.backgroundColor!;

    expect(color.resolve({}), AppColors.grey);
  });

  testWidgets(
      'WHEN button is pressed THEN button background color is mediumRed',
      (tester) async {
    await tester.pumpWidget(
      TestAppWidget(
        child: DefaultButton(
          onPressed: () {},
          title: const Text(''),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final button =
        tester.widget<ElevatedButton>(find.byKey(const Key('DefaultButton')));
    final color = button.style!.backgroundColor!;

    expect(color.resolve({MaterialState.pressed}), AppColors.mediumRed);
  });
}
