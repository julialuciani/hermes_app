import 'package:flutter/widgets.dart';
import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/utils/extensions/build_context_extensions.dart';

class ExtractTextTitle extends StatelessWidget {
  final PeriodGroup periodGroup;
  const ExtractTextTitle({
    super.key,
    required this.periodGroup,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    String getExtractText() {
      if (periodGroup == PeriodGroup.year) {
        return 'Extrato Mensal';
      }
      return 'Extrato Diário';
    }

    return Text(
      getExtractText(),
      style: typography.bold.medium,
    );
  }
}
