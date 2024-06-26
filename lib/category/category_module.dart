import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category/category_form_cubit.dart';
import 'package:hermes_app/category/category/category_form_page.dart';
import 'package:hermes_app/category/category/category_icon_selector/category_icon_selector_cubit.dart';
import 'package:hermes_app/category/category/category_icon_selector/category_icon_selector_page.dart';
import 'package:hermes_app/category/category/category_icon_selector/get_icons_segments_use_case.dart';
import 'package:hermes_app/category/category/load_category_by_id_cubit.dart';
import 'package:hermes_app/category/category/load_category_by_id_use_case.dart';
import 'package:hermes_app/category/category/save_category_use_case.dart';
import 'package:hermes_app/category/category_listing/category_listing_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing__filters_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_page.dart';
import 'package:hermes_app/category/category_listing/delete_category_by_id_use_case.dart';
import 'package:hermes_app/category/category_listing/get_categories_use_case.dart';

class CategoryModule extends Module {
  @override
  List<Bind<Object>> binds = [
    //UseCases
    Bind.factory<SaveCategoryUseCase>(
      (i) => SaveCategoryUseCase(i()),
    ),
    Bind.factory<GetIconsSegmentsUseCase>(
      (i) => GetIconsSegmentsUseCase(),
    ),
    Bind.factory<GetCategoriesUseCase>(
      (i) => GetCategoriesUseCase(i()),
    ),
    Bind.factory<LoadCategoryByIdUseCase>(
      (i) => LoadCategoryByIdUseCase(i()),
    ),
    Bind.factory<DeleteCategoryByIdUseCase>(
      (i) => DeleteCategoryByIdUseCase(i()),
    ),

    //Cubits
    Bind.lazySingleton<CategoryFormCubit>(
      (i) => CategoryFormCubit(i()),
    ),
    Bind.lazySingleton<CategoryIconSelectorCubit>(
      (i) => CategoryIconSelectorCubit(i()),
    ),
    Bind.lazySingleton<CategoryListingCubit>(
      (i) => CategoryListingCubit(i(), i()),
    ),
    Bind.lazySingleton<CategoryListingFiltersCubit>(
      (i) => CategoryListingFiltersCubit(),
    ),
    Bind.factory<LoadCategoryByIdCubit>(
      (i) => LoadCategoryByIdCubit(i()),
    ),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/register/',
      child: (context, args) => CategoryFormPage(
        categoryId: int.tryParse(args.queryParams['categoryId'] ?? ''),
      ),
      transition: TransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    ),
    ChildRoute(
      '/icon_selector/',
      child: (context, args) => const CategoryIconSelectorPage(),
      transition: TransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    ),
    ChildRoute(
      '/',
      child: (context, args) => const CategoryListingPage(),
      transition: TransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    ),
  ];
}
