import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category/category_form_cubit.dart';
import 'package:hermes_app/category/category/category_form_page.dart';
import 'package:hermes_app/category/category/save_category_use_case.dart';

class CategoryModule extends Module {
  @override
  List<Bind<Object>> binds = [
    //UseCases
    Bind.factory<SaveCategoryUseCase>(
      (i) => SaveCategoryUseCase(i()),
    ),

    //Cubits
    Bind.lazySingleton<CategoryFormCubit>(
      (i) => CategoryFormCubit(i()),
    ),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const CategoryFormPage(),
      transition: TransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    ),
  ];
}
