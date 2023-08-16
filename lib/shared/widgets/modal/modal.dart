import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class Modal extends StatelessWidget {
  final Widget content;

  const Modal({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 16),
          content
        ],
      ),
    );
  }
}
