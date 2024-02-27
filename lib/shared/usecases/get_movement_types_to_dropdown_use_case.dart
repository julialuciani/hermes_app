import 'package:hermes_app/shared/entities/movement_type_model.dart';
import 'package:hermes_app/shared/repositories/movement_type_repository.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class GetMovementTypesToDropdownUseCase {
  final MovementTypeRepository _repository;

  GetMovementTypesToDropdownUseCase(
    this._repository,
  );

  Future<List<DropdownItem>> call() async {
    final result = await _repository.getAll();

    return result.transform();
  }
}

extension _MovementTypeToDropdownItemTransformer on List<MovementTypeModel> {
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
