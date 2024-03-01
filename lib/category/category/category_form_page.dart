import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category/category_form_cubit.dart';
import 'package:hermes_app/category/category/widgets/color_selector_box.dart';
import 'package:hermes_app/category/category/widgets/icon_selector_box.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppBar(
        title: 'Categoria',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formCubit.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
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
              const Input(
                label: 'Nome *',
              ),
              const SizedBox(height: 20),
              IconSelectorBox(
                onChange: (icon) {},
                onTapOthers: () {},
              ),
              const SizedBox(height: 20),
              ColorSelectorBox(
                currentColor: AppColors.basicOrange,
                onChange: (color) {},
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
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
