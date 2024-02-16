import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String? denialText;
  final String? confirmationText;
  const ConfirmationDialog({
    super.key,
    required this.title,
    this.denialText,
    this.confirmationText,
  });

  Future<bool> show(BuildContext context) async {
    final isConfirmed = await showDialog<bool?>(
      context: context,
      builder: (context) {
        return this;
      },
    );

    return isConfirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              return AppColors.white;
            }),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            denialText ?? "Não",
            style: TextStyle(color: AppColors.red),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              return AppColors.red;
            }),
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(confirmationText ?? "Sim"),
        ),
      ],
    );
  }
}
