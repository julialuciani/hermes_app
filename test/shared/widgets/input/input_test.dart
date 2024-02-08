import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';

import '../../../utils/test_app_widget.dart';

void main() {
  testWidgets("WHEN input is not enabled THEN look fill color", (tester) async {
    final expectedFillColor = AppColors.grey;

    await tester.pumpWidget(
      const TestAppWidget(
        child: Input(enabled: false),
      ),
    );

    await tester.pumpAndSettle();

    final finder = find.byType(TextField);

    final widget = tester.widget<TextField>(finder);

    final decoration = widget.decoration;

    expect(decoration?.fillColor, expectedFillColor);
  });

  testWidgets("WHEN input doesn't have label THEN label Text is not shown",
      (tester) async {
    await tester.pumpWidget(
      const TestAppWidget(
        child: Input(),
      ),
    );

    await tester.pumpAndSettle();

    final finder = find.text("Test Text");

    expect(finder, findsNothing);
  });
  testWidgets("WHEN input have label THEN label Text is shown", (tester) async {
    await tester.pumpWidget(
      const TestAppWidget(
        child: Input(
          label: "Input Label",
        ),
      ),
    );

    await tester.pumpAndSettle();

    final finder = find.text("Input Label");

    expect(finder, findsOneWidget);
  });

  testWidgets("WHEN validator return something THEN error text is shown",
      (tester) async {
    await tester.pumpWidget(
      TestAppWidget(
        child: Input(
          label: "Input Label",
          validator: (value) {
            if (value == "error_text") {
              return "Error";
            }
            return null;
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(EditableText), "error_text");

    await tester.pump();
    await tester.pump();

    expect(find.text("Error"), findsOneWidget);
  });

  testWidgets("WHEN anything is typed THEN ensure onChanged was called",
      (tester) async {
    int timesOnChangedWasCalled = 0;

    await tester.pumpWidget(
      TestAppWidget(
        child: Input(
          onChanged: (_) {
            timesOnChangedWasCalled++;
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(EditableText), "AAAAAA");

    await tester.pump();
    await tester.pump();

    expect(timesOnChangedWasCalled, 1);

    await tester.enterText(find.byType(EditableText), "bbb");

    await tester.pump();
    await tester.pump();

    expect(timesOnChangedWasCalled, 2);
  });

  testWidgets("WHEN anything is typed THEN ensure controller.text is updated",
      (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      TestAppWidget(
        child: Input(
          controller: controller,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(EditableText), "AAAAAA");

    await tester.pump();
    await tester.pump();

    expect(controller.text, "AAAAAA");

    await tester.enterText(find.byType(EditableText), "bbb");

    await tester.pump();
    await tester.pump();

    expect(controller.text, "bbb");
  });
}
