import 'package:flutter/material.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class Modal extends StatelessWidget {
  final List<Widget> content;
  final double initialSize;
  final double minimalSize;
  final double maximumSize;

  const Modal({
    Key? key,
    required this.content,
    this.initialSize = 0.5,
    this.minimalSize = 0.25,
    this.maximumSize = 0.85,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 0.5,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                width: 50,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              ...content
            ],
          ),
        );
      },
    );
  }
}
