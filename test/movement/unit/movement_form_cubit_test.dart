import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/movement/movement/movement_form_cubit.dart';
import 'package:hermes_app/movement/movement/save_movement_use_case.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/usecases/get_picture_from_camera_use_case.dart';
import 'package:mockito/mockito.dart';

class GetPictureFromCameraUseCaseMock extends Mock
    implements GetPictureFromCameraUseCase {}

class SaveMovementUsecaseMock extends Mock implements SaveMovementUseCase {}

void main() {
  late GetPictureFromCameraUseCase getPictureFromCameraUseCaseMock;
  late SaveMovementUseCase saveMovementUseCaseMock;

  setUpAll(
    () {
      saveMovementUseCaseMock = SaveMovementUsecaseMock();
      getPictureFromCameraUseCaseMock = GetPictureFromCameraUseCase();
    },
  );

  test(
    'WHEN instantiate cubit THEN movement should only have date',
    () {
      //ARRANGE
      final cubit = MovementFormCubit(
        getPictureFromCameraUseCaseMock,
        saveMovementUseCaseMock,
      );

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
      );

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
    'WHEN reset THEN movement should only have date',
    () {
      //ARRANGE
      final cubit = MovementFormCubit(
        getPictureFromCameraUseCaseMock,
        saveMovementUseCaseMock,
      );
      final mockImage = Uint8List(255);

      //ACT
      cubit.change(typeId: Nullable(1));
      cubit.change(categoryId: Nullable(2));
      cubit.change(description: 'Mock Description');
      cubit.change(image: Nullable(mockImage));
      cubit.change(value: 'R\$  20,00');

      expect(cubit.movement.categoryId, 2);
      expect(cubit.movement.typeId, 1);
      expect(cubit.movement.description, 'Mock Description');
      expect(cubit.movement.image, mockImage);
      expect(cubit.movement.value, 20.00);

      cubit.reset();

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
    'WHEN change value THEN value be represented as double in the correct value',
    () {
      //ARRANGE
      final cubit = MovementFormCubit(
        getPictureFromCameraUseCaseMock,
        saveMovementUseCaseMock,
      );

      //ACT
      cubit.change(value: 'R\$  2.345,21');

      //ASSERT
      expect(cubit.movement.value, 2345.21);
    },
  );
}
