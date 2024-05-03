import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';

class BalanceScreenFilterCubit extends Cubit<FetchMovementsFilters> {
  BalanceScreenFilterCubit() : super(_getDefaultFilters());

  void change(FetchMovementsFilters filters) => emit(filters);

  static FetchMovementsFilters _getDefaultFilters() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    if (now.month == 12) {
      // Handle December edge case
      endOfMonth = DateTime(now.year + 1, 1, 0, 23, 59, 59);
    }
    return FetchMovementsFilters(
      dateStart: startOfMonth,
      dateEnd: endOfMonth,
    );
  }
}
