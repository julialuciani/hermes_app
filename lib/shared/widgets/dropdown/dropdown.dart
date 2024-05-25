import 'package:flutter/material.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';
import 'package:hermes_app/shared/widgets/input/utils/input_mixin.dart';

class Dropdown extends StatefulWidget {
  final List<DropdownItem> items;
  final void Function(int? itemId) onChanged;
  final int? value;
  final String? Function(int? value)? validator;
  final String? label;
  final bool enabled;
  const Dropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.label,
    this.enabled = true,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> with InputMixin {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: typography.bold.medium,
          ),
          const SizedBox(height: 6),
        ],
        DropdownButtonFormField<int>(
          style: widget.enabled
              ? typography.regular.medium
              : typography.paragraph.medium,
          value: widget.value,
          items: [
            const DropdownMenuItem(child: Text("Selecione...")),
            ...widget.items.map((e) => DropdownMenuItem(
                  value: e.value,
                  onTap: () => widget.onChanged(e.value),
                  child: Text(e.description),
                )),
          ],
          validator: (value) {
            final result = widget.validator?.call(value);

            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) => setState(() => errorText = result),
            );

            return null;
          },
          onChanged: widget.enabled ? (id) => widget.onChanged(id) : null,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            filled: true,
            border: OutlineInputBorder(
              borderSide: getBorderSideByErrorText(errorText),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: getBorderSideByErrorText(errorText),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: getBorderSideByErrorText(errorText),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        if (errorText != null && widget.enabled) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: typography.regular.small.copyWith(
              color: AppColors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
