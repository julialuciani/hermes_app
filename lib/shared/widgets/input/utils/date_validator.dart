import 'package:intl/intl.dart';

class DateValidator {
  static DateValidatorResult validate(String input) {
    final String locale = Intl.systemLocale;
    try {
      final date = DateFormat.yMd(locale).parse(input);
      if (date.year < 2000) return DateValidatorResult.isBefore2000;
      if (date.isAfter(DateTime.now())) return DateValidatorResult.isAfterNow;
      return DateValidatorResult.correct;
    } on FormatException {
      return DateValidatorResult.formatError;
    }
  }
}

enum DateValidatorResult {
  correct,
  formatError,
  isBefore2000,
  isAfterNow,
}
