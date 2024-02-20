import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';
import 'package:intl/intl.dart';

class InputDate extends StatefulWidget {
  final TextEditingController? controller;

  /// [label] it's used to show a text above the [InputDate] widget. Indicates what should be typed
  final String? label;

  /// [validator] it's used to validate the input of the user and allows to show an error text below the [InputDate]
  final String? Function(String? value)? validator;

  /// [onChanged] will be called everytime that the value changes
  final void Function(DateTime? value)? onChanged;

  /// [onFieldSubmitted] will be called when the user finishes typing and clicks done on his keyboard
  final void Function(String)? onFieldSubmitted;

  /// [enabled] if not enabled, many of the functions of the input will not be called and its style will be different
  final bool enabled;

  /// [InputDate] is a widget used to allow user to insert data of any type into the app
  const InputDate({
    Key? key,
    this.controller,
    this.label,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  DateTime? currentDate = DateTime.now();
  TextEditingController? controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    controller?.text = formatDate(currentDate!);
    super.initState();
  }

  String formatDate(DateTime date) {
    String locale = Intl.systemLocale;
    return DateFormat.yMd(locale).format(date);
  }

  void onChangeDate(DateTime date, [bool ignoreController = false]) {
    currentDate = date;
    widget.onChanged?.call(date);
    if (!ignoreController) {
      controller?.text = formatDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: controller,
      enabled: widget.enabled,
      label: widget.label,
      onChanged: (value) {
        if (value == null || value.isEmpty) return;
        String locale = Intl.systemLocale;
        try {
          final date = DateFormat.yMd(locale).parse(value);
          onChangeDate(date, true);
        } on FormatException {
          currentDate = null;
          return;
        }
      },
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      keyboardType: TextInputType.datetime,
      suffixIcon: GestureDetector(
        onTap: () async {
          final newDate = await showDatePicker(
              context: context,
              initialDate: currentDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.red,
                      onPrimary: AppColors.white,
                      onSurface: AppColors.darkGrey,
                    ),
                  ),
                  child: child!,
                );
              });

          if (newDate == null) return;
          onChangeDate(newDate);
        },
        child: Icon(
          Icons.calendar_today,
          color: AppColors.black,
          size: 24,
        ),
      ),
    );
  }
}
