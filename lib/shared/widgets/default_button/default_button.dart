import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/default_button/utils/default_button_mixin.dart';

class DefaultButton extends StatelessWidget with DefaultButtonMixin {
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
    final typography = context.typography;
    return SizedBox(
      height: 56,
      width: context.screenWidth,
      child: ElevatedButton(
        key: const Key('DefaultButton'),
        style: ButtonStyle(
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          backgroundColor: getBackgroundColor(enabled),
        ),
        onPressed: enabled && !isLoading ? onPressed : null,
        child: isLoading
            ? CircularProgressIndicator(
                color: AppColors.white,
              )
            : DefaultTextStyle(
                style: typography.bold.large.copyWith(color: AppColors.white),
                child: title,
              ),
      ),
    );
  }
}
