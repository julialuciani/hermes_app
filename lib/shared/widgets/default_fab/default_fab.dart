import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class DefaultFab extends StatelessWidget {
  final VoidCallback onTap;
  const DefaultFab({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key('create_new_movement_fab'),
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
