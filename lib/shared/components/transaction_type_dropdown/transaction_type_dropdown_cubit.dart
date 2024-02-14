import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown_state.dart';
import 'package:hermes_app/shared/models/unknown_error.dart';
import 'package:hermes_app/shared/usecases/get_transaction_types_to_dropdown_use_case.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class TransactionTypeDropdownCubit extends Cubit<TransactionTypeDropdownState> {
  final GetTransactionTypesToDropdownUseCase _usecase;
  TransactionTypeDropdownCubit(
    this._usecase,
  ) : super(TransactionTypeDropdownLoading());

  void fetch() async {
    emit(TransactionTypeDropdownLoading());
    try {
      final List<DropdownItem> items = await _usecase();

      emit(TransactionTypeDropdownSuccess(items.translate()));
    } catch (exception, stackTrace) {
      final unknownError =
          UnknownError(error: exception, stackTrace: stackTrace);
      emit(TransactionTypeDropdownError(unknownError));
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
