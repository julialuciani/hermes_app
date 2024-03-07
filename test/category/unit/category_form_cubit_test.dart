import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_app/category/category/category_form_cubit.dart';
import 'package:hermes_app/category/category/models/utils/category_form_model_validator.dart';
import 'package:hermes_app/category/category/save_category_use_case.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/theme/app_icons.dart';
import 'package:mockito/mockito.dart';

class SaveCategoryUseCaseMock extends Mock implements SaveCategoryUseCase {}

void main() {
  late SaveCategoryUseCase saveCategoryUseCaseMock;

  setUpAll(() {
    saveCategoryUseCaseMock = SaveCategoryUseCaseMock();
  });

  test(
    'WHEN validate valid category THEN ensure return is success',
    () {
      //ARRANGE
      final sut = CategoryFormCubit(
        saveCategoryUseCaseMock,
      );

      //ACT
      sut.change(
        color: Nullable(AppColors.black),
        icon: Nullable(AppIcons.airplane),
        movementTypeId: Nullable(1),
        name: "Mock",
      );
      final validationResult = sut.validateForm();

      //ASSERT
      expect(validationResult, CategoryFormValidationResult.success);
    },
  );

  test(
    'WHEN validate invalid category THEN ensure return is expected',
    () {
      //ARRANGE
      final sut = CategoryFormCubit(
        saveCategoryUseCaseMock,
      );

      //ACT
      final validationResult1 = sut.validateForm();
      sut.change(movementTypeId: Nullable(1));
      final validationResult2 = sut.validateForm();
      sut.change(name: "Mock Name Test");
      final validationResult3 = sut.validateForm();
      sut.change(icon: Nullable(AppIcons.bed));
      final validationResult4 = sut.validateForm();

      //ASSERT
      expect(validationResult1, CategoryFormValidationResult.typeNotNull);
      expect(validationResult2, CategoryFormValidationResult.nameNotNull);
      expect(validationResult3, CategoryFormValidationResult.iconNotNull);
      expect(validationResult4, CategoryFormValidationResult.colorNotNull);
    },
  );
}
