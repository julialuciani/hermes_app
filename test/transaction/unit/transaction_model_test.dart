import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/entities/transaction_model.dart';
import 'package:hermes_app/shared/validators/transaction_validator.dart';

void main() {
  test(
    'WHEN transaction has no typeId THEN validate should return expected error',
    () {
      //ARRANGE
      const transaction = TransactionModel();

      //ACT
      final validationResult = transaction.validate();

      //ASSERT
      expect(validationResult, TransactionValidatorResult.typeCantBeNull);
    },
  );
  test(
    'WHEN transaction has no value THEN validate should return expected error',
    () {
      //ARRANGE
      const transaction = TransactionModel(
        typeId: 1,
      );

      //ACT
      final validationResult = transaction.validate();

      //ASSERT
      expect(validationResult, TransactionValidatorResult.valueCantBeNull);
    },
  );

  test(
    'WHEN transaction has no date THEN validate should return expected error',
    () {
      //ARRANGE
      const transaction = TransactionModel(
        typeId: 1,
        value: 20.00,
      );

      //ACT
      final validationResult = transaction.validate();

      //ASSERT
      expect(validationResult, TransactionValidatorResult.dateCantBeNull);
    },
  );

  test(
    'WHEN transaction has no category THEN validate should return expected error',
    () {
      //ARRANGE
      final transaction = TransactionModel(
        typeId: 1,
        value: 20.00,
        date: DateTime.now(),
      );

      //ACT
      final validationResult = transaction.validate();

      //ASSERT
      expect(validationResult, TransactionValidatorResult.categoryCantBeNull);
    },
  );

  test(
    'WHEN transaction is valid THEN validate should return sucess',
    () {
      //ARRANGE
      final transaction = TransactionModel(
        typeId: 1,
        value: 20.00,
        date: DateTime.now(),
        categoryId: 1,
      );

      //ACT
      final validationResult = transaction.validate();

      //ASSERT
      expect(validationResult, TransactionValidatorResult.success);
    },
  );
}
