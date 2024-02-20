import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/usecases/get_picture_from_camera_use_case.dart';
import 'package:hermes_app/transaction/pages/transaction/save_transaction_use_case.dart';
import 'package:hermes_app/transaction/pages/transaction/transaction_form_cubit.dart';
import 'package:mockito/mockito.dart';

class GetPictureFromCameraUseCaseMock extends Mock
    implements GetPictureFromCameraUseCase {}

class SaveTransactionUsecaseMock extends Mock
    implements SaveTransactionUseCase {}

void main() {
  late GetPictureFromCameraUseCase getPictureFromCameraUseCaseMock;
  late SaveTransactionUseCase saveTransactionUseCaseMock;

  setUpAll(
    () {
      saveTransactionUseCaseMock = SaveTransactionUsecaseMock();
      getPictureFromCameraUseCaseMock = GetPictureFromCameraUseCase();
    },
  );

  test(
    "WHEN instantiate cubit THEN transaction should only have date",
    () {
      //ARRANGE
      final cubit = TransactionFormCubit(
        getPictureFromCameraUseCaseMock,
        saveTransactionUseCaseMock,
      );

      //ACT
      final transaction = cubit.transaction;

      //ASSERT
      expect(transaction.date, isNotNull);
      expect(transaction.categoryId, isNull);
      expect(transaction.description, isNull);
      expect(transaction.image, isNull);
      expect(transaction.typeId, isNull);
      expect(transaction.value, isNull);
      expect(transaction.id, isNull);
    },
  );

  test(
    "WHEN change typeId THEN category should be set to null",
    () {
      //ARRANGE
      final cubit = TransactionFormCubit(
        getPictureFromCameraUseCaseMock,
        saveTransactionUseCaseMock,
      );

      //ACT
      cubit.change(typeId: Nullable(1));
      cubit.change(categoryId: Nullable(2));
      expect(cubit.transaction.categoryId, 2);

      cubit.change(typeId: Nullable(null));

      //ASSERT
      expect(cubit.transaction.categoryId, isNull);
    },
  );

  test(
    "WHEN reset THEN transaction should only have date",
    () {
      //ARRANGE
      final cubit = TransactionFormCubit(
        getPictureFromCameraUseCaseMock,
        saveTransactionUseCaseMock,
      );
      final mockImage = Uint8List(255);

      //ACT
      cubit.change(typeId: Nullable(1));
      cubit.change(categoryId: Nullable(2));
      cubit.change(description: "Mock Description");
      cubit.change(image: Nullable(mockImage));
      cubit.change(value: "R\$  20,00");

      expect(cubit.transaction.categoryId, 2);
      expect(cubit.transaction.typeId, 1);
      expect(cubit.transaction.description, "Mock Description");
      expect(cubit.transaction.image, mockImage);
      expect(cubit.transaction.value, 20.00);

      cubit.reset();

      final transaction = cubit.transaction;

      //ASSERT
      expect(transaction.date, isNotNull);
      expect(transaction.categoryId, isNull);
      expect(transaction.description, isNull);
      expect(transaction.image, isNull);
      expect(transaction.typeId, isNull);
      expect(transaction.value, isNull);
      expect(transaction.id, isNull);
    },
  );

  test(
    "WHEN change value THEN value be represented as double in the correct value",
    () {
      //ARRANGE
      final cubit = TransactionFormCubit(
        getPictureFromCameraUseCaseMock,
        saveTransactionUseCaseMock,
      );

      //ACT
      cubit.change(value: "R\$  2.345,21");

      //ASSERT
      expect(cubit.transaction.value, 2345.21);
    },
  );
}
