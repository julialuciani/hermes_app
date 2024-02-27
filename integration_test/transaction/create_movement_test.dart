import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/main.dart' as app;

void main() {
  testWidgets(
    'Create new valid movement and Save',
    (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('create_new_movement_fab')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('movement_type_dropdown')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // This is a specific case of the dropdown, it somehow identifies two components as the same item, so we must select the second one
      await tester.tap(find.text('Entrada').last);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.enterText(find.byKey(const Key('value_input')), '2000');
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump(const Duration(seconds: 1));

      await tester.enterText(
        find.byKey(const Key('description_input')),
        'mock description',
      );
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const ValueKey(0)));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('btn_save_movement')));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Transação salva com sucesso'), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
    },
  );
}
