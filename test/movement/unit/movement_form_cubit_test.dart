import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/movement/movement/delete_movement_use_case.dart';
import 'package:hermes_app/movement/movement/movement_form_cubit.dart';
import 'package:hermes_app/movement/movement/save_movement_use_case.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/usecases/get_picture_from_camera_use_case.dart';
import 'package:mockito/mockito.dart';

class GetPictureFromCameraUseCaseMock extends Mock
    implements GetPictureFromCameraUseCase {}

class SaveMovementUsecaseMock extends Mock implements SaveMovementUseCase {}

class DeleteMovementUseCaseMock extends Mock implements DeleteMovementUseCase {}

void main() {
  late GetPictureFromCameraUseCase getPictureFromCameraUseCaseMock;
  late SaveMovementUseCase saveMovementUseCaseMock;
  late DeleteMovementUseCase deleteMovementUseCaseMock;

  setUpAll(
    () {
      saveMovementUseCaseMock = SaveMovementUsecaseMock();
      getPictureFromCameraUseCaseMock = GetPictureFromCameraUseCase();
      deleteMovementUseCaseMock = DeleteMovementUseCaseMock();
    },
  );

  test(
    'WHEN instantiate cubit THEN movement should only have date',
    () {
      //ARRANGE
      final cubit = MovementFormCubit(
        getPictureFromCameraUseCaseMock,
        saveMovementUseCaseMock,
        deleteMovementUseCaseMock,
      );
      cubit.init();

      //ACT
      final movement = cubit.movement;

      //ASSERT
      expect(movement.date, isNotNull);
      expect(movement.categoryId, isNull);
      expect(movement.description, isNull);
      expect(movement.image, isNull);
      expect(movement.typeId, isNull);
      expect(movement.value, isNull);
      expect(movement.id, isNull);
    },
  );

  test(
    'WHEN change typeId THEN category should be set to null',
    () {
      //ARRANGE
      final cubit = MovementFormCubit(
        getPictureFromCameraUseCaseMock,
        saveMovementUseCaseMock,
        deleteMovementUseCaseMock,
      );
      cubit.init();

      //ACT
      cubit.change(typeId: Nullable(1));
      cubit.change(categoryId: Nullable(2));
      expect(cubit.movement.categoryId, 2);

      cubit.change(typeId: Nullable(null));

      //ASSERT
      expect(cubit.movement.categoryId, isNull);
    },
  );

  test(
    'WHEN change value THEN value be represented as double in the correct value',
    () {
      //ARRANGE
      final cubit = MovementFormCubit(
        getPictureFromCameraUseCaseMock,
        saveMovementUseCaseMock,
        deleteMovementUseCaseMock,
      );
      cubit.init();

      //ACT
      cubit.change(value: 'R\$  2.345,21');

      //ASSERT
      expect(cubit.movement.value, 2345.21);
    },
  );
}
