import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_state.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown.dart';

class MovementTypeDropdown extends StatefulWidget {
  final int? value;
  final void Function(int?) onChanged;
  final String? Function(int?)? validator;
  final bool isRequired;
  const MovementTypeDropdown({
    super.key,
    this.value,
    required this.onChanged,
    this.validator,
    this.isRequired = true,
  });

  @override
  State<MovementTypeDropdown> createState() => _MovementTypeDropdownState();
}

class _MovementTypeDropdownState extends State<MovementTypeDropdown> {
  final cubit = Modular.get<MovementTypeDropdownCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovementTypeDropdownCubit, MovementTypeDropdownState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is MovementTypeDropdownSuccess) {
          return Dropdown(
            label: widget.isRequired ? 'Tipo *' : 'Tipo',
            items: state.items,
            onChanged: widget.onChanged,
            value: widget.value,
            validator: widget.validator,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
