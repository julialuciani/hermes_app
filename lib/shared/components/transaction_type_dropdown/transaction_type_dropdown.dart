import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown.dart';

class TransactionTypeDropdown extends StatelessWidget {
  final int? value;
  const TransactionTypeDropdown({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Dropdown(
      label: "Tipo",
      items: const [],
      onChanged: (value) {},
      value: value,
    );
  }
}
