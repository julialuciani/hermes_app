import 'package:hermes_app/shared/repositories/movement_repository.dart';

class DeleteMovementUseCase {
  final MovementRepository _movementRepository;

  DeleteMovementUseCase(this._movementRepository);

  Future<void> call(int id) async {
    await _movementRepository.delete(id);
  }
}
