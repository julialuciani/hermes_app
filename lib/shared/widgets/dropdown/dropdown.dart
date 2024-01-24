import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class Dropdown extends StatefulWidget {
  final List<DropdownItem> items;
  final void Function(int itemId) onChanged;
  final int? value;
  const Dropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.value,
      items: widget.items
          .map((e) => DropdownMenuItem(
                value: e.value,
                onTap: () => widget.onChanged(e.value),
                child: Text(e.description),
              ))
          .toList(),
      onChanged: (id) => id != null ? widget.onChanged(id) : null,
      decoration: const InputDecoration(),
    );
  }
}
