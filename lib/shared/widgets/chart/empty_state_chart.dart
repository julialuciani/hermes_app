import 'package:flutter/material.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class EmptyStateChart extends StatelessWidget {
  const EmptyStateChart({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final typography = context.typography;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: height * 0.25,
              width: height * 0.25,
              child: CircularProgressIndicator(
                value: 0,
                backgroundColor: AppColors.lightGrey,
                strokeWidth: 12,
              ),
            ),
            Text(
              'Sem dados para exibir',
              style: typography.bold.medium.copyWith(
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
