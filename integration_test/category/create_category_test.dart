import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/category/category/widgets/color_selector_box.dart';
import 'package:hermes_app/main.dart' as app;
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/theme/app_icons.dart';

import '../utils/widget_tester_extensions.dart';

void main() {
  testWidgets(
    'Create new valid movement and Save',
    (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await tester.tapAndPump(find.byKey(const Key('create_new_movement_fab')));
      await tester.tapAndPump(find.byKey(const Key('movement_type_dropdown')));
      // This is a specific case of the dropdown, it somehow identifies two components as the same item, so we must select the second one
      await tester.tapAndPump(find.text('Entrada').last);
      await tester.tapAndPump(find.byKey(const Key('btn_others')));
      await tester.tapAndPump(find.byKey(const Key('create_new_category_fab')));
      await tester.tapAndPump(
        find.byKey(const Key('movement_type_dropdown')),
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // This is a specific case of the dropdown, it somehow identifies two components as the same item, so we must select the second one
      await tester.tapAndPump(find.text('Entrada').last);
      await tester.enterText(
        find.byKey(const Key('input_name')),
        'new category name',
      );
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump(const Duration(seconds: 1));
      await tester.tapAndPump(
        find.byKey(ValueKey(AppIcons.highlightIcons.first)),
      );
      await tester.dragUntilVisible(
        find.byType(ColorSelectorBox),
        find.byKey(const Key('scroll_category_form')),
        const Offset(50, 300),
      );
      await tester.pump(const Duration(seconds: 1));
      await tester.tapAndPump(
        find.byKey(
          ValueKey(AppColors.colorsToHighlight.first),
        ),
      );
      await tester.tapAndPump(find.byKey(const Key('bnt_save_category')));
      expect(find.text('Categoria salva com sucesso'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
    },
  );
}
