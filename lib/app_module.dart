import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/home/home_module.dart';
import 'package:hermes_app/shared/database/idatabase.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';
import 'package:hermes_app/shared/repositories/transaction_type_repository.dart';
import 'package:hermes_app/shared/usecases/get_transaction_types_to_dropdown_usecase.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';
import 'package:hermes_app/transaction/transaction_module.dart';

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
    Bind.factory<GetTransactionTypesToDropdownUsecase>(
      (i) => GetTransactionTypesToDropdownUsecase(i()),
    ),

    //Cubits
    Bind.factory<RegisterErrorCubit>(
      (i) => RegisterErrorCubit(''),
    )
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
