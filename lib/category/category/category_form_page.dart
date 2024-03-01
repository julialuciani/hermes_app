import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category/category_form_cubit.dart';
import 'package:hermes_app/category/category/widgets/category_header.dart';
import 'package:hermes_app/category/category/widgets/color_selector_box.dart';
import 'package:hermes_app/category/category/widgets/icon_selector_box.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final movementTypeCubit = Modular.get<MovementTypeDropdownCubit>();
  final formCubit = Modular.get<CategoryFormCubit>();

  @override
  void initState() {
    movementTypeCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppBar(
        title: 'Categoria',
      ),
      body: BlocBuilder(
          bloc: formCubit,
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formCubit.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    CategoryHeader(
                      category: formCubit.category,
                    ),
                    const SizedBox(height: 20),
                    MovementTypeDropdown(
                      onChanged: (typeId) {
                        formCubit.change(movementTypeId: Nullable(typeId));
                      },
                      value: formCubit.category.movementTypeId,
                      validator: (typeId) {
                        if (typeId == null) return 'Campo obrigatório';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Input(
                      label: 'Nome *',
                      controller: formCubit.nameController,
                      onChanged: (value) {
                        formCubit.change(name: value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    IconSelectorBox(
                      selectedColor: formCubit.category.color,
                      selectedIcon: formCubit.category.icon,
                      onChange: (icon) {
                        formCubit.change(icon: Nullable(icon));
                      },
                      onTapOthers: () {
                        //TODO: navigate to select others icons page
                      },
                    ),
                    const SizedBox(height: 20),
                    ColorSelectorBox(
                      currentColor: formCubit.category.color,
                      onChange: (color) {
                        formCubit.change(color: Nullable(color));
                      },
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            );
          }),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        height: 100,
        child: DefaultButton(
          onPressed: () {},
          title: const Text('Confirmar'),
        ),
      ),
    );
  }
}
