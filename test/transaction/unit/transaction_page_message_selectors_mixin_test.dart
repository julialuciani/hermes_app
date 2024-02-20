import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/shared/validators/transaction_validator.dart';
import 'package:hermes_app/shared/widgets/input/utils/date_validator.dart';
import 'package:hermes_app/transaction/pages/transaction/utils/transaction_page_message_selectors_mixin.dart';

class _MockClass with TransactionPageMessageSelectorsMixin {}

void main() {
  late _MockClass sut;

  setUpAll(() {
    sut = _MockClass();
  });

  test(
    "WHEN call for get error message THEN verify if return is expected",
    () {
      //ACT
      final successMessage = sut.getErrorMessageByTransactionValidatorResult(
        result: TransactionValidatorResult.success,
      );
      final categoryCantBeNullMessage =
          sut.getErrorMessageByTransactionValidatorResult(
        result: TransactionValidatorResult.categoryCantBeNull,
      );
      final dateCantBeNullMessage =
          sut.getErrorMessageByTransactionValidatorResult(
        result: TransactionValidatorResult.dateCantBeNull,
      );
      final typeCantBeNullMessage =
          sut.getErrorMessageByTransactionValidatorResult(
        result: TransactionValidatorResult.typeCantBeNull,
      );
      final valueCantBeNullMessage =
          sut.getErrorMessageByTransactionValidatorResult(
        result: TransactionValidatorResult.valueCantBeNull,
      );

      //ASSERT
      expect(successMessage, isNull);
      expect(categoryCantBeNullMessage, "Escolha uma categoria");
      expect(dateCantBeNullMessage, "Defina uma data válida");
      expect(typeCantBeNullMessage, "Selecione um valor no campo tipo");
      expect(valueCantBeNullMessage, "Preencha o campo valor");
    },
  );

  test(
    "WHEN call for get validate message by date validator THEN verify if return is expected",
    () {
      //ACT
      final correctMessage = sut.getValidatorMessageByDateValidatorResult(
        dateValidatorResult: DateValidatorResult.correct,
      );
      final formatErrorMessage = sut.getValidatorMessageByDateValidatorResult(
        dateValidatorResult: DateValidatorResult.formatError,
      );
      final isAfterNowMessage = sut.getValidatorMessageByDateValidatorResult(
        dateValidatorResult: DateValidatorResult.isAfterNow,
      );
      final isBefore2000Message = sut.getValidatorMessageByDateValidatorResult(
        dateValidatorResult: DateValidatorResult.isBefore2000,
      );

      //ASSERT
      expect(correctMessage, isNull);
      expect(formatErrorMessage, "Formato de data inválido");
      expect(isAfterNowMessage, "Data não pode ser depois de hoje");
      expect(isBefore2000Message, "Data não pode ser antes de 2000");
    },
  );
}
