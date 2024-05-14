import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/icon_utils.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:intl/intl.dart';

class ExtractDialog extends StatelessWidget {
  const ExtractDialog({
    super.key,
    required this.period,
    required this.movements,
  });

  final String period;
  final List<MovementModel> movements;

  static void show(
    BuildContext context, {
    required String period,
    required List<MovementModel> movements,
  }) {
    showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, _, __, child) {
        const begin = Offset(0, 1);
        const end = Offset(0, 0);
        const curve = Curves.ease;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: tween.animate(_),
          child: child,
        );
      },
      pageBuilder: (context, _, __) {
        return ExtractDialog(
          period: period,
          movements: movements,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    String formatCurrency(double value) {
      final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
      return format.format(value);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: DefaultAppBar(
        title: 'Extrato',
        subtitle: period,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: movements.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final movement = movements[index];

          return ContentBox(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: movement.categoryColor,
                      radius: 24,
                      child: Icon(
                        IconUtils.getIconByName(movement.categoryIcon!),
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movement.categoryName!,
                          style: typography.bold.medium,
                        ),
                        if (movement.description != null)
                          Text(
                            movement.description!,
                            style: typography.regular.small,
                          ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      formatCurrency(movement.value!),
                      style: typography.bold.medium,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Ver mais',
                    style: typography.regular.medium.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
