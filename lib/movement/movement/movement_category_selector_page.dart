import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category_routes.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_cubit.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_state.dart';
import 'package:hermes_app/shared/components/category_selector_box/widgets/category_icon.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';

import 'movement_form_cubit.dart';

class MovementCategorySelectorPage extends StatefulWidget {
  const MovementCategorySelectorPage({super.key});

  @override
  State<MovementCategorySelectorPage> createState() =>
      _MovementCategorySelectorPageState();
}

class _MovementCategorySelectorPageState
    extends State<MovementCategorySelectorPage> {
  final categorySelectorBoxCubit = Modular.get<CategorySelectorBoxCubit>();
  final formCubit = Modular.get<MovementFormCubit>();

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Selecionar categoria',
      ),
      body: BlocBuilder<CategorySelectorBoxCubit, CategorySelectorBoxState>(
        bloc: categorySelectorBoxCubit,
        builder: (context, state) {
          if (state is CategorySelectorBoxLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategorySelectorBoxError) {
            final typeId = formCubit.movement.typeId;
            if (typeId == null) {
              CherryToast.error(
                title: Text(
                  'Selecione um tipo de transação para acessar essa tela',
                  style: typography.regular.medium,
                ),
              ).show(context);
              Modular.to.pop();
            } else {
              return DefaultErrorWidget(
                title: 'Erro ao buscar as categorias',
                failure: state.failure,
                description: 'Clique no botão para buscar novamente',
                buttonLabel: 'Tentar novamente',
                onPressed: () async {
                  categorySelectorBoxCubit.fetch(typeId);
                },
              );
            }
          }

          if (state is CategorySelectorBoxSuccess) {
            final currentCategoryId = formCubit.movement.categoryId;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Center(
                    child: Wrap(
                      spacing: 8,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: state.categories.map((category) {
                        return CategoryIcon(
                          category: category,
                          isSelected: category.id == currentCategoryId,
                          onChange: (categoryId) {
                            formCubit.change(categoryId: Nullable(categoryId));
                            Modular.to.pop();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: GestureDetector(
        key: const Key('create_new_movement_fab'),
        onTap: () {
          Modular.to.pushNamed(CategoryRoutes.category).then((_) {
            final typeId = formCubit.movement.typeId;
            if (typeId == null) return;
            categorySelectorBoxCubit.fetch(typeId);
          });
        },
        child: Container(
          height: 60,
          width: 60,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
