import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category_module.dart';
import 'package:hermes_app/home/home_module.dart';
import 'package:hermes_app/movement/movement_module.dart';
import 'package:hermes_app/shared/components/category_dropdown/category_dropdown_cubit.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_cubit.dart';
import 'package:hermes_app/shared/database/idatabase.dart';
import 'package:hermes_app/shared/repositories/category_repository.dart';
import 'package:hermes_app/shared/repositories/movement_repository.dart';
import 'package:hermes_app/shared/repositories/movement_type_repository.dart';
import 'package:hermes_app/shared/usecases/get_categories_by_movement_type_id_use_case.dart';
import 'package:hermes_app/shared/usecases/get_movement_types_to_dropdown_use_case.dart';
import 'package:hermes_app/shared/usecases/get_picture_from_camera_use_case.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';

import 'shared/components/movement_type_dropdown/movement_type_dropdown_cubit.dart';

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
    Bind.factory<MovementTypeRepository>(
      (i) => MovementTypeRepository(i()),
    ),
    Bind.factory<MovementRepository>(
      (i) => MovementRepository(i()),
    ),

    //UseCases
    Bind.factory<GetMovementTypesToDropdownUseCase>(
      (i) => GetMovementTypesToDropdownUseCase(i()),
    ),
    Bind.factory<GetCategoriesByMovementTypeIdUseCase>(
      (i) => GetCategoriesByMovementTypeIdUseCase(i()),
    ),
    Bind.factory<GetPictureFromCameraUseCase>(
      (i) => GetPictureFromCameraUseCase(),
    ),

    //Cubits
    Bind.factory<RegisterErrorCubit>(
      (i) => RegisterErrorCubit(''),
    ),
    Bind.lazySingleton<MovementTypeDropdownCubit>(
      (i) => MovementTypeDropdownCubit(i()),
    ),
    Bind.lazySingleton<CategorySelectorBoxCubit>(
      (i) => CategorySelectorBoxCubit(i()),
    ),
    Bind.lazySingleton<CategoryDropdownCubit>(
      (i) => CategoryDropdownCubit(i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: HomeModule(),
    ),
    ModuleRoute(
      '/movement',
      module: MovementModule(),
    ),
    ModuleRoute(
      '/category',
      module: CategoryModule(),
    ),
  ];
}
