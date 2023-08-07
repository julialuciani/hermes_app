import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/select/utils/select_mixin.dart';

import '../../theme/app_colors.dart';

class Select extends StatefulWidget {
  final List<SelectData> data;
  final void Function(dynamic) onPressed;
  final dynamic selectedValue;

  const Select({
    Key? key,
    required this.data,
    required this.onPressed,
    required this.selectedValue,
  }) : super(key: key);

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> with SelectMixin {
  Future<void> scrollToSelectedItem(GlobalKey key) async {
    final context = key.currentContext!;
    await Scrollable.ensureVisible(
      context,
      alignment: 0.5,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          final selectData = widget.data[index];
          final isSelected = selectData.value == widget.selectedValue;
          final key = GlobalKey();
          return GestureDetector(
            onTap: () async {
              widget.onPressed(selectData.value);
              await scrollToSelectedItem(key);
            },
            child: AnimatedContainer(
              key: key,
              duration: const Duration(milliseconds: 100),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: getBackgroundColor(isSelected),
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  selectData.label,
                  style: TextStyle(
                    color: getTextColor(isSelected),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
      ),
    );
  }
}

class SelectData {
  final dynamic value;
  final String label;

  const SelectData({
    required this.value,
    required this.label,
  });
}
