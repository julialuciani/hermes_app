import 'package:intl/intl.dart';

extension FormatCurrencyExtension on double {
  String formatCurrency() {
    return NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    ).format(this);
  }
}
