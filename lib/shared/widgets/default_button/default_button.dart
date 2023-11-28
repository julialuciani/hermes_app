import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget title;
  final bool isLoading;
  final bool enabled;
  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ButtonStyle(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (!enabled) return AppColors.grey;
              if (states.contains(MaterialState.pressed)) {
                return AppColors.mediumRed;
              }
              return AppColors.red;
            })),
        onPressed: enabled || isLoading ? onPressed : null,
        child: isLoading
            ? const CircularProgressIndicator()
            : DefaultTextStyle(
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                child: title,
              ),
      ),
    );
  }
}
