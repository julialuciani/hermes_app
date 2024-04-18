import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/category_dropdown/category_dropdown_state.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

import 'category_dropdown_cubit.dart';

class CategoryDropdown extends StatefulWidget {
  final int? value;
  final void Function(int?) onChanged;
  final String? Function(int?)? validator;
  const CategoryDropdown({
    super.key,
    this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown>
    with WidgetsBindingObserver {
  final cubit = Modular.get<CategoryDropdownCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDropdownCubit, CategoryDropdownState>(
      bloc: cubit,
      builder: (context, state) {
        List<DropdownItem> items = [];

        if (state is CategoryDropdownSuccess) {
          items = state.items;
        }

        return Dropdown(
          label: "Categoria *",
          items: items,
          onChanged: widget.onChanged,
          value: widget.value,
          validator: widget.validator,
        );
      },
    );
  }
}
