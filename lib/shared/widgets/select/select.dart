import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/select/utils/select_mixin.dart';

import '../../theme/app_colors.dart';

class Select extends StatefulWidget {
  final String? label;
  final List<SelectData> data;
  final void Function(dynamic) onPressed;
  final dynamic selectedValue;

  const Select({
    Key? key,
    this.label,
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
    final typography = context.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: typography.regular.medium,
          ),
          const SizedBox(height: 6),
        ],
        SizedBox(
          height: 30,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                  decoration: BoxDecoration(
                    color: getBackgroundColor(isSelected),
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      selectData.label,
                      style: typography.regular.small.copyWith(
                        color: getTextColor(isSelected),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
          ),
        ),
      ],
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
