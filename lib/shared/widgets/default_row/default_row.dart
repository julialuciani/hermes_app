import 'package:flutter/widgets.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/text_size.dart';

class DefaultRow extends StatelessWidget {
  final String title;
  final String value;
  final TextSize textSize;
  const DefaultRow({
    Key? key,
    required this.title,
    required this.value,
    required this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    TextStyle getTypography(TextSize size) {
      switch (size) {
        case TextSize.small:
          return typography.regular.small;
        case TextSize.medium:
          return typography.regular.medium;
        default:
          return typography.regular.small;
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
          const Spacer(),
          Text(
            value,
            style: getTypography(textSize),
          ),
        ],
      ),
    );
  }
}
