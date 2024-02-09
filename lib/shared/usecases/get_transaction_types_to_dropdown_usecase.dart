import 'package:hermes_app/shared/entities/transaction_type.dart';
import 'package:hermes_app/shared/repositories/transaction_type_repository.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class GetTransactionTypesToDropdownUsecase {
  final TransactionTypeRepository _repository;

  GetTransactionTypesToDropdownUsecase(
    this._repository,
  );

  Future<List<DropdownItem>> call() async {
    final result = await _repository.getAll();

    return result.transform();
  }
}

extension _TransactionTypeToDropdownItemTransformer on List<TransactionType> {
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
