import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';

import '../../../utils/test_app_widget.dart';

void main() {
  late List<SelectData> data;
  late int selectedValue;

  setUpAll(() {
    selectedValue = 0;
    data = [
      const SelectData(value: 0, label: 'Value 0'),
      const SelectData(value: 1, label: 'Value 1'),
      const SelectData(value: 2, label: 'Value 2'),
    ];
  });
  testWidgets(
      "GIVEN a list of select data WHEN load Select THEN change value selected",
      (tester) async {
    await tester.pumpWidget(
      TestAppWidget(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Select(
              data: data,
              selectedValue: selectedValue,
              onPressed: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(selectedValue, 0);

    await tester.tap(find.text("Value 1"));
    await tester.pumpAndSettle();

    expect(selectedValue, 1);
  });
}
