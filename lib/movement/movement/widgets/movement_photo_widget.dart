import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class MovementPhotoWidget extends StatefulWidget {
  final Uint8List? image;
  final VoidCallback onRemove;
  final VoidCallback onTap;
  const MovementPhotoWidget({
    super.key,
    required this.image,
    required this.onRemove,
    required this.onTap,
  });

  @override
  State<MovementPhotoWidget> createState() => _MovementPhotoWidgetState();
}

class _MovementPhotoWidgetState extends State<MovementPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 1.5,
      dashPattern: const [4, 4],
      borderType: BorderType.RRect,
      padding: const EdgeInsets.all(16),
      color: AppColors.skyBlue,
      child: Column(
        children: [
          if (widget.image != null) ...[
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: widget.onRemove,
                child: Icon(
                  Icons.delete,
                  color: AppColors.red,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _PhotoWidget(
              image: widget.image!,
            )
          ] else
            _EmptyPhotoWidget(
              onTap: widget.onTap,
            ),
        ],
      ),
    );
  }
}

class _PhotoWidget extends StatelessWidget {
  final Uint8List image;
  const _PhotoWidget({
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Image.memory(
      image,
      width: screenWidth * 0.5,
    );
  }
}

class _EmptyPhotoWidget extends StatelessWidget {
  final VoidCallback onTap;
  const _EmptyPhotoWidget({
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.photo,
              size: 64,
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
