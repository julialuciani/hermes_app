import 'package:hermes_app/shared/entities/transaction_type_model.dart';
import 'package:hermes_app/shared/repositories/transaction_type_repository.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class GetTransactionTypesToDropdownUseCase {
  final TransactionTypeRepository _repository;

  GetTransactionTypesToDropdownUseCase(
    this._repository,
  );

  Future<List<DropdownItem>> call() async {
    final result = await _repository.getAll();

    return result.transform();
  }
}

extension _TransactionTypeToDropdownItemTransformer
    on List<TransactionTypeModel> {
  List<DropdownItem> transform() {
    return List.from(
      map(
        (e) => DropdownItem(
          description: e.name,
          value: e.id!,
        ),
      ),
    );
  }
}
