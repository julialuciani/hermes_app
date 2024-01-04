import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? Function(String? value) validator;
  final void Function(String? value) onChange;
  final VoidCallback onFieldSubmitted;

  const Input({
    Key? key,
    this.controller,
    this.label,
    required this.validator,
    required this.onChange,
    required this.onFieldSubmitted,
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Column(
        children: [
          if (widget.label != null) ...[],
        ],
      ),
    );
  }
}
