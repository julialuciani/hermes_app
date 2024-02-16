import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/home_module.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_cubit.dart';
import 'package:hermes_app/shared/database/idatabase.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';
import 'package:hermes_app/shared/repositories/transaction_type_repository.dart';
import 'package:hermes_app/shared/usecases/get_categories_by_transaction_type_id_use_case.dart';
import 'package:hermes_app/shared/usecases/get_picture_from_camera_use_case.dart';
import 'package:hermes_app/shared/usecases/get_transaction_types_to_dropdown_use_case.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';
import 'package:hermes_app/transaction/transaction_module.dart';

import 'shared/components/transaction_type_dropdown/transaction_type_dropdown_cubit.dart';

class AppModule extends Module {
  @override
  final List<Bind<Object>> binds = [
    //Services
    Bind.factory<IDatabase>(
      (i) => DatabaseImp(),
    ),

    //Repositories
    Bind.factory<CategoryRepository>(
      (i) => CategoryRepository(i()),
    ),
    Bind.factory<TransactionTypeRepository>(
      (i) => TransactionTypeRepository(i()),
    ),

    //Usecases
    Bind.factory<GetTransactionTypesToDropdownUseCase>(
      (i) => GetTransactionTypesToDropdownUseCase(i()),
    ),
    Bind.factory<GetCategoriesByTransactionTypeIdUseCase>(
      (i) => GetCategoriesByTransactionTypeIdUseCase(i()),
    ),
    Bind.factory<GetPictureFromCameraUseCase>(
      (i) => GetPictureFromCameraUseCase(),
    ),

    //Cubits
    Bind.factory<RegisterErrorCubit>(
      (i) => RegisterErrorCubit(''),
    ),
    Bind.lazySingleton<TransactionTypeDropdownCubit>(
      (i) => TransactionTypeDropdownCubit(i()),
    ),
    Bind.lazySingleton<CategorySelectorBoxCubit>(
      (i) => CategorySelectorBoxCubit(i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: HomeModule(),
    ),
    ModuleRoute(
      '/transaction',
      module: TransactionModule(),
    ),
  ];
}
