import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class TransactionPhotoWidget extends StatefulWidget {
  const TransactionPhotoWidget({
    super.key,
  });

  @override
  State<TransactionPhotoWidget> createState() => _TransactionPhotoWidgetState();
}

class _TransactionPhotoWidgetState extends State<TransactionPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return DottedBorder(
      strokeWidth: 2,
      dashPattern: const [4, 4],
      borderType: BorderType.RRect,
      padding: const EdgeInsets.all(48),
      color: AppColors.skyBlue,
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.photo,
              size: 80,
              color: AppColors.grey,
            ),
            Text(
              "Adicionar foto",
              style: typography.paragraph.medium,
            ),
          ],
        ),
      ),
    );
  }
}
