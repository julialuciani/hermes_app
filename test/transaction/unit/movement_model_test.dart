import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/validators/movement_validator.dart';

void main() {
  test(
    'WHEN movement has no typeId THEN validate should return expected error',
    () {
      //ARRANGE
      const movement = MovementModel();

      //ACT
      final validationResult = movement.validate();

      //ASSERT
      expect(validationResult, MovementValidatorResult.typeCantBeNull);
    },
  );
  test(
    'WHEN movement has no value THEN validate should return expected error',
    () {
      //ARRANGE
      const movement = MovementModel(
        typeId: 1,
      );

      //ACT
      final validationResult = movement.validate();

      //ASSERT
      expect(validationResult, MovementValidatorResult.valueCantBeNull);
    },
  );

  test(
    'WHEN movement has no date THEN validate should return expected error',
    () {
      //ARRANGE
      const movement = MovementModel(
        typeId: 1,
        value: 20.00,
      );

      //ACT
      final validationResult = movement.validate();

      //ASSERT
      expect(validationResult, MovementValidatorResult.dateCantBeNull);
    },
  );

  test(
    'WHEN movement has no category THEN validate should return expected error',
    () {
      //ARRANGE
      final movement = MovementModel(
        typeId: 1,
        value: 20.00,
        date: DateTime.now(),
      );

      //ACT
      final validationResult = movement.validate();

      //ASSERT
      expect(validationResult, MovementValidatorResult.categoryCantBeNull);
    },
  );

  test(
    'WHEN movement is valid THEN validate should return sucess',
    () {
      //ARRANGE
      final movement = MovementModel(
        typeId: 1,
        value: 20.00,
        date: DateTime.now(),
        categoryId: 1,
      );

      //ACT
      final validationResult = movement.validate();

      //ASSERT
      expect(validationResult, MovementValidatorResult.success);
    },
  );
}
