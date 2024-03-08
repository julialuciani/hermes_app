import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing__filters_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filter_modal.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';

class CategoryListingFilterRow extends StatefulWidget {
  const CategoryListingFilterRow({super.key});

  @override
  State<CategoryListingFilterRow> createState() =>
      _CategoryListingFilterRowState();
}

class _CategoryListingFilterRowState extends State<CategoryListingFilterRow> {
  final filtersCubit = Modular.get<CategoryListingFiltersCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Input(
            suffixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
            controller: filtersCubit.searchController,
            onChanged: (search) {
              filtersCubit.change(search: Nullable(search));
            },
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const CategoryListingFilterModal(),
            );
          },
          child: const FilterIcon(),
        ),
      ],
    );
  }
}

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        FontAwesomeIcons.filter,
        color: AppColors.darkGrey,
      ),
    );
  }
}
