import 'package:flutter/material.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/icon_utils.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';

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
                        if (movement.description != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            movement.description!,
                            style: typography.paragraph.small,
                          ),
                        ]
                      ],
                    ),
                    const Spacer(),
                    Text(
                      movement.value?.toStringAsFixed(2) ?? '',
                      style: typography.bold.medium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.close,
                        color: AppColors.darkGrey,
                      ),
                      label: Text(
                        'Remover',
                        style: typography.regular.medium.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        elevation: 0,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.darkGrey,
                      ),
                      label: Text(
                        'Editar',
                        style: typography.regular.medium.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
