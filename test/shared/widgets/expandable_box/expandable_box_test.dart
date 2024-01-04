import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/widgets/expandable_box/expandable_box.dart';

import '../../../utils/test_app_widget.dart';

void main() {
  testWidgets(
    "WHEN is not expanded THEN children should not be shown",
    (tester) async {
      await tester.pumpWidget(
        const TestAppWidget(
          child: ExpandableBox(
            title: Text("Mock Title"),
            children: [
              Text("MockText"),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("MockText"), findsNothing);
    },
  );
  testWidgets(
    "WHEN is expanded THEN children should be shown",
    (tester) async {
      await tester.pumpWidget(
        const TestAppWidget(
          child: ExpandableBox(
            title: Text("Mock Title"),
            children: [
              Text("MockText"),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ExpandableBox));
      await tester.pumpAndSettle();

      expect(find.text("MockText"), findsOneWidget);
    },
  );

  testWidgets(
    "WHEN initiallyExpanded is true THEN children should be shown",
    (tester) async {
      await tester.pumpWidget(
        const TestAppWidget(
          child: ExpandableBox(
            title: Text("Mock Title"),
            initiallyExpanded: true,
            children: [
              Text("MockText"),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("MockText"), findsOneWidget);
    },
  );
}
