import 'package:flutter/widgets.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/text_size.dart';

class DefaultTitle extends StatelessWidget {
  final String title;

  final TextSize textSize;
  const DefaultTitle({
    Key? key,
    required this.title,
    required this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    TextStyle getTypography(TextSize size) {
      switch (size) {
        case TextSize.small:
          return typography.bold.small;
        case TextSize.medium:
          return typography.bold.medium;
        default:
          return typography.bold.small;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: getTypography(textSize),
          ),
        ],
      ),
    );
  }
}
