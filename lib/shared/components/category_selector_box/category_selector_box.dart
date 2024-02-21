import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_cubit.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_state.dart';
import 'package:hermes_app/shared/components/category_selector_box/utils/get_categories_to_show.dart';
import 'package:hermes_app/shared/components/category_selector_box/widgets/category_icon.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';

class CategorySelectorBox extends StatefulWidget {
  final void Function(int categoryId) onChange;
  final int? selectedCategory;
  final VoidCallback onTapOthers;
  const CategorySelectorBox({
    super.key,
    required this.onChange,
    required this.selectedCategory,
    required this.onTapOthers,
  });

  @override
  State<CategorySelectorBox> createState() => _CategorySelectorBoxState();
}

class _CategorySelectorBoxState extends State<CategorySelectorBox> {
  final categorySelectorBoxCubit = Modular.get<CategorySelectorBoxCubit>();
  final registerErrorCubit = Modular.get<RegisterErrorCubit>();
  StreamSubscription<ChangeTransactionTypeEvent>? eventListener;

  @override
  void initState() {
    eventListener = eventBus.on<ChangeTransactionTypeEvent>().listen(
      (event) {
        if (event.transactionTypeId == null) {
          categorySelectorBoxCubit.reset();
        } else {
          categorySelectorBoxCubit.fetch(event.transactionTypeId!);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    eventListener?.cancel();
    categorySelectorBoxCubit.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final screenWidth = MediaQuery.of(context).size.width;
    return ContentBox(
      outsideLabel: "Categoria *",
      child: BlocBuilder<CategorySelectorBoxCubit, CategorySelectorBoxState>(
        bloc: categorySelectorBoxCubit,
        builder: (context, state) {
          if (state is CategorySelectorBoxError) {
            registerErrorCubit.registerError(state.failure);
            return const Center(
              child: Text("Sinto muito, um erro aconteceu"),
            );
          }

          if (state is CategorySelectorBoxSuccess) {
            final categoriesToShow = GetCategoriesToShow.get(
              state.categories,
              widget.selectedCategory,
            );

            return Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 16,
              runSpacing: 8,
              children: [
                ...categoriesToShow.map((category) {
                  return CategoryIcon(
                    key: ValueKey(categoriesToShow.indexOf(category)),
                    category: category,
                    isSelected: widget.selectedCategory == category.id,
                    onChange: (categoryId) {
                      widget.onChange(categoryId);
                    },
                  );
                }),
                Container(
                  width: screenWidth * 0.22,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: widget.onTapOthers,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 32,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Outros",
                        style: typography.regular.small.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text("Selecione um tipo de transação"),
          );
        },
      ),
    );
  }
}
