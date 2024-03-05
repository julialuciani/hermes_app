import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/repositories/movement_repository.dart';

class SaveMovementUseCase {
  final MovementRepository _repository;

  SaveMovementUseCase(
    this._repository,
  );

  Future<int> call(MovementModel movement) async {
    if (movement.id != null) {
      await _repository.update(movement);
      return movement.id!;
    } else {
      return await _repository.insert(movement);
    }
  }
}
