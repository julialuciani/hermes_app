import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category_listing/category_listing_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing__filters_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filter_row.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filters_state.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';
import 'package:hermes_app/category/category_listing/widgets/category_list_widget.dart';
import 'package:hermes_app/category/category_routes.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';
import 'package:hermes_app/shared/widgets/default_fab/default_fab.dart';
import 'package:hermes_app/shared/widgets/dialogs/confirmation_dialog.dart';

class CategoryListingPage extends StatefulWidget {
  const CategoryListingPage({super.key});

  @override
  State<CategoryListingPage> createState() => _CategoryListingPageState();
}

class _CategoryListingPageState extends State<CategoryListingPage> {
  final categoryListingCubit = Modular.get<CategoryListingCubit>();
  final filtersCubit = Modular.get<CategoryListingFiltersCubit>();
  final registerErrorCubit = Modular.get<RegisterErrorCubit>();

  @override
  void initState() {
    categoryListingCubit.fetch(filtersCubit.state.toParams());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    void showToastOnDelete(bool success) {
      if (success) {
        CherryToast.success(
          title: Text(
            'Categoria excluída com sucesso!',
            style: typography.regular.medium,
          ),
        ).show(context);
        filtersCubit.change();
      } else {
        CherryToast.error(
          title: Text(
            'Erro ao remover categoria',
            style: typography.regular.medium,
          ),
        ).show(context);
      }
    }

    return Scaffold(
      appBar: const DefaultAppBar(title: 'Categorias'),
      body: BlocListener<CategoryListingFiltersCubit,
          CategoryListingFiltersState>(
        bloc: filtersCubit,
        listener: (context, state) {
          categoryListingCubit.fetch(state.toParams());
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CategoryListingFilterRow(),
              const SizedBox(height: 16),
              BlocBuilder(
                bloc: categoryListingCubit,
                builder: (context, state) {
                  if (state is CategoryListingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CategoryListingError) {
                    return Expanded(
                      child: SmallDefaultErrorWidget(
                        title: 'Ocorreu um erro ao buscar as categorias',
                        failure: state.failure,
                        description: '',
                        buttonLabel: 'Tentar novamente',
                        onPressed: () async => filtersCubit.reset(),
                      ),
                    );
                  }
                  if (state is CategoryListingSuccess) {
                    return Expanded(
                      child: CategoryListWidget(
                        categories: state.categories,
                        onTap: (category) {
                          final route =
                              "${CategoryRoutes.categoryRegister}?categoryId=${category.id}";

                          Modular.to
                              .pushNamed(route)
                              .then((_) => filtersCubit.change());
                        },
                        onRemove: (category) async {
                          final isConfirmed = await const ConfirmationDialog(
                            title: 'Deseja excluir a categoria?',
                            content:
                                'Isso fará com que TODAS as movimentações atreladas a ela sejam excluídas',
                          ).show(context);

                          if (isConfirmed) {
                            categoryListingCubit
                                .deleteCategory(
                                  category,
                                  registerErrorCubit.registerError,
                                )
                                .then(showToastOnDelete);
                          }
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: DefaultFab(
        key: const Key('create_category_fab'),
        onTap: () {
          Modular.to
              .pushNamed(CategoryRoutes.categoryRegister)
              .then((_) => filtersCubit.change());
        },
      ),
    );
  }
}
