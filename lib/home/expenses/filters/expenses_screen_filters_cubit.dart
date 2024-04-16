import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';

class ExpensesScreenFiltersCubit extends Cubit<FetchMovementsFilters> {
  ExpensesScreenFiltersCubit()
      : super(
          FetchMovementsFilters(
            dateStart: DateTime(DateTime.now().year, DateTime.now().month, 1),
            dateEnd: DateTime(
                DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59),
            movementTypeId: 2,
          ),
        );

  void change(FetchMovementsFilters filters) => emit(filters);
}
