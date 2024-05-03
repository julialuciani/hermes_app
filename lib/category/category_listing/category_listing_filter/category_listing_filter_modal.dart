import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing__filters_cubit.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown.dart';
import 'package:hermes_app/shared/components/movement_type_dropdown/movement_type_dropdown_cubit.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/widgets/modal/modal.dart';

class CategoryListingFilterModal extends StatefulWidget {
  const CategoryListingFilterModal({super.key});

  @override
  State<CategoryListingFilterModal> createState() =>
      _CategoryListingFilterModalState();
}

class _CategoryListingFilterModalState
    extends State<CategoryListingFilterModal> {
  final movementTypeCubit = Modular.get<MovementTypeDropdownCubit>();
  final filtersCubit = Modular.get<CategoryListingFiltersCubit>();

  @override
  void initState() {
    movementTypeCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return Modal(
      content: Column(
        children: [
          Text(
            'Filtros',
            style: typography.regular.large,
          ),
          const SizedBox(height: 16),
          MovementTypeDropdown(
            isRequired: false,
            onChanged: (id) {
              filtersCubit.change(movementTypeId: Nullable(id));
            },
            value: filtersCubit.state.movementTypeId,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
