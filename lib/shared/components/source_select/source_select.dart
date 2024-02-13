import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/select/select.dart';

class SourceSelect extends StatefulWidget {
  final void Function(dynamic) onPressed;
  final dynamic selectedValue;
  final int? transactionTypeId;
  const SourceSelect({
    super.key,
    required this.onPressed,
    required this.selectedValue,
    this.transactionTypeId,
  });

  @override
  State<SourceSelect> createState() => _SourceSelectState();
}

class _SourceSelectState extends State<SourceSelect> {
  @override
  void initState() {
    //TODO: call fetch based on transactionTypeId
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Select(
      label: "Fonte *",
      data: const [],
      onPressed: widget.onPressed,
      selectedValue: widget.selectedValue,
    );
  }
}
