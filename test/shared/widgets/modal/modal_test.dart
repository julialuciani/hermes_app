import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/widgets/modal/modal.dart';

import '../../../utils/test_app_widget.dart';

void main() {
  testWidgets(
    "GIVEN a widget WHEN load Modal THEN look for the items of the content",
    (tester) async {
      await tester.pumpWidget(
        TestAppWidget(
          child: Modal(
            content: SizedBox(
              height: 200,
              child: ListView(
                children: List.generate(5, (index) => Text("$index")),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(5));
    },
  );
}
