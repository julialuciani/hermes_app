import 'package:flutter/material.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class MenuItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isPressed = false;

  void _updateState(bool isPressed) {
    setState(() {
      _isPressed = isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    Color getContainerColorByState() {
      return _isPressed ? AppColors.lightBlue : AppColors.white;
    }

    Color getIconAndTextColorByState() {
      return _isPressed ? AppColors.blue : AppColors.darkGrey;
    }

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => _updateState(true),
      onTapUp: (_) => _updateState(false),
      onTapCancel: () => _updateState(false),
      onLongPress: () => _updateState(true),
      onLongPressEnd: (_) => _updateState(false),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: getContainerColorByState(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: getIconAndTextColorByState(),
            ),
            const SizedBox(width: 16),
            Text(
              widget.text,
              style: typography.bold.medium.copyWith(
                color: getIconAndTextColorByState(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
