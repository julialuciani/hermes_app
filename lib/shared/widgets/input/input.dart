import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/input/utils/input_mixin.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;

  /// [label] it's used to show a text above the [Input] widget. Indicates what should be the typed
  final String? label;

  /// [validator] it's used to validate the input of the user and allows to show a error text below the [Input]
  final String? Function(String? value)? validator;

  /// [onChanged] will be called everytime that the value changes
  final void Function(String? value)? onChanged;

  /// [onFieldSubmitted] will be called when the user finish typing and click done on its keyboard
  final void Function(String)? onFieldSubmitted;

  /// [enabled] if not enabled, many of the functions of the input will not be called and its style will be different
  final bool enabled;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;

  final Widget? suffixIcon;

  final String? hint;

  /// [Input] is a widget used to allow user to insert data of any type into the app
  const Input({
    Key? key,
    this.controller,
    this.label,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.hint,
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> with InputMixin {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;
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
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
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
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          scrollPadding: EdgeInsets.only(
            bottom: viewInsetsBottom + 40,
          ),
          decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: widget.suffixIcon,
              suffixIconColor: AppColors.darkGrey,
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
