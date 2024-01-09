import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/input/utils/input_mixin.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool enabled;

  const Input({
    Key? key,
    this.controller,
    this.label,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> with InputMixin {
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
            style: typography.regular.medium,
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          cursorColor: AppColors.black,
          onChanged: widget.onChanged,
          validator: (value) {
            final result = widget.validator?.call(value);

            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) => setState(() => errorText = result),
            );

            return null;
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              fillColor: getInputFillColor(widget.enabled),
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
              )),
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
