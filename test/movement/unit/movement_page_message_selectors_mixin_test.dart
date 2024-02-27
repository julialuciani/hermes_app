import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/movement/pages/movement/utils/movement_page_message_selectors_mixin.dart';
import 'package:hermes_app/shared/validators/movement_validator.dart';
import 'package:hermes_app/shared/widgets/input/utils/date_validator.dart';

class _MockClass with MovementPageMessageSelectorsMixin {}

void main() {
  late _MockClass sut;

  setUpAll(() {
    sut = _MockClass();
  });

  test(
    'WHEN call for get error message THEN verify if return is expected',
    () {
      //ACT
      final successMessage = sut.getErrorMessageByMovementValidatorResult(
        result: MovementValidatorResult.success,
      );
      final categoryCantBeNullMessage =
          sut.getErrorMessageByMovementValidatorResult(
        result: MovementValidatorResult.categoryCantBeNull,
      );
      final dateCantBeNullMessage =
          sut.getErrorMessageByMovementValidatorResult(
        result: MovementValidatorResult.dateCantBeNull,
      );
      final typeCantBeNullMessage =
          sut.getErrorMessageByMovementValidatorResult(
        result: MovementValidatorResult.typeCantBeNull,
      );
      final valueCantBeNullMessage =
          sut.getErrorMessageByMovementValidatorResult(
        result: MovementValidatorResult.valueCantBeNull,
      );

      //ASSERT
      expect(successMessage, isNull);
      expect(categoryCantBeNullMessage, 'Escolha uma categoria');
      expect(dateCantBeNullMessage, 'Defina uma data válida');
      expect(typeCantBeNullMessage, 'Selecione um valor no campo tipo');
      expect(valueCantBeNullMessage, 'Preencha o campo valor');
    },
  );

  test(
    'WHEN call for get validate message by date validator THEN verify if return is expected',
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
      expect(formatErrorMessage, 'Formato de data inválido');
      expect(isAfterNowMessage, 'Data não pode ser depois de hoje');
      expect(isBefore2000Message, 'Data não pode ser antes de 2000');
    },
  );
}
