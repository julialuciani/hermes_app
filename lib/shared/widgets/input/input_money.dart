import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';

class InputMoney extends StatefulWidget {
  final TextEditingController? controller;

  /// [label] it's used to show a text above the [InputMoney] widget. Indicates what should be typed
  final String? label;

  /// [validator] it's used to validate the input of the user and allows to show an error text below the [InputMoney]
  final String? Function(String? value)? validator;

  /// [onChanged] will be called everytime that the value changes
  final void Function(String? value)? onChanged;

  /// [onFieldSubmitted] will be called when the user finishes typing and clicks done on his keyboard
  final void Function(String)? onFieldSubmitted;

  /// [enabled] if not enabled, many of the functions of the input will not be called and its style will be different
  final bool enabled;

  /// [InputMoney] is a widget used to allow user to insert data of any type into the app
  const InputMoney({
    Key? key,
    this.controller,
    this.label,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<InputMoney> createState() => _InputMoneyState();
}

class _InputMoneyState extends State<InputMoney> {
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: "R\$ ",
    enableNegative: false,
    locale: 'pt_BR',
  );

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: widget.controller,
      enabled: widget.enabled,
      label: widget.label,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[_formatter],
    );
  }
}
