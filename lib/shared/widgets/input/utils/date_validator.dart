import 'package:intl/intl.dart';

class DateValidator {
  static bool validate(String input) {
    final String locale = Intl.systemLocale;
    try {
      final date = DateFormat.yMd(locale).parse(input);
      if (date.year < 2000) {
        return false;
      }
      return true;
    } on FormatException {
      return false;
    }
  }
}
