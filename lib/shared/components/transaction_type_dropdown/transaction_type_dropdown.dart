import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown_state.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class TransactionTypeDropdown extends StatefulWidget {
  final int? value;
  final void Function(int?) onChanged;
  const TransactionTypeDropdown({
    super.key,
    this.value,
    required this.onChanged,
  });

  @override
  State<TransactionTypeDropdown> createState() =>
      _TransactionTypeDropdownState();
}

class _TransactionTypeDropdownState extends State<TransactionTypeDropdown> {
  final cubit = Modular.get<TransactionTypeDropdownCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionTypeDropdownCubit,
        TransactionTypeDropdownState>(
      bloc: cubit,
      builder: (context, state) {
        List<DropdownItem> items = [];

        if (state is TransactionTypeDropdownSuccess) {
          items = state.items;
        }

        return Dropdown(
          label: "Tipo *",
          items: items,
          onChanged: widget.onChanged,
          value: widget.value,
        );
      },
    );
  }
}
