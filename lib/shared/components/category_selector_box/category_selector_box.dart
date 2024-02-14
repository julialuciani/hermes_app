import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_cubit.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_state.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/utils/event_bus.dart';
import 'package:hermes_app/shared/utils/icon_utils.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';

class CategorySelectorBox extends StatefulWidget {
  final void Function(int categoryId) onChange;
  final int? selectedCategory;
  const CategorySelectorBox({
    super.key,
    required this.onChange,
    required this.selectedCategory,
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
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
            final categories = state.categories.take(9);
            return Wrap(
              children: [
                ...categories.map((category) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: category.color,
                        child: Icon(
                          IconUtils.getIconByName(category.icon),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category.name,
                        style: typography.regular.small.copyWith(
                          color: category.color,
                        ),
                      ),
                    ],
                  );
                }),
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
