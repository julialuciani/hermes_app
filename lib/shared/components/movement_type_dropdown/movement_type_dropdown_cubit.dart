import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_state.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';
import 'package:hermes_app/shared/usecases/get_movement_types_to_dropdown_use_case.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class MovementTypeDropdownCubit extends Cubit<MovementTypeDropdownState> {
  final GetMovementTypesToDropdownUseCase _usecase;
  MovementTypeDropdownCubit(
    this._usecase,
  ) : super(MovementTypeDropdownLoading());

  void fetch() async {
    emit(MovementTypeDropdownLoading());
    try {
      final List<DropdownItem> items = await _usecase();

      emit(MovementTypeDropdownSuccess(items.translate()));
    } catch (exception, stackTrace) {
      final unknownError =
          UnknownError(error: exception, stackTrace: stackTrace);
      emit(MovementTypeDropdownError(unknownError));
    }
  }
}

extension _TranslateDropdownItemDescriptionExtension on List<DropdownItem> {
  List<DropdownItem> translate() {
    return map((item) {
      return DropdownItem(
        description: _getDescription(item.description),
        value: item.value,
      );
    }).toList();
  }

  String _getDescription(String description) {
    switch (description) {
      case "income":
        return "Entrada";
      case "expenses":
        return "Gastos";
      case "investments":
        return "Investimentos";
      default:
        return "";
    }
  }
}
