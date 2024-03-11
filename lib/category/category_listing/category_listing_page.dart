import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category_listing/category_listing_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing__filters_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filter_row.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filters_state.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/utils/icon_utils.dart';
import 'package:hermes_app/shared/widgets/content_box/content_box.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';

class CategoryListingPage extends StatefulWidget {
  const CategoryListingPage({super.key});

  @override
  State<CategoryListingPage> createState() => _CategoryListingPageState();
}

class _CategoryListingPageState extends State<CategoryListingPage> {
  final categoryListingCubit = Modular.get<CategoryListingCubit>();
  final filtersCubit = Modular.get<CategoryListingFiltersCubit>();

  @override
  void initState() {
    categoryListingCubit.fetch(filtersCubit.state.toParams());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Categorias'),
      body: BlocListener<CategoryListingFiltersCubit,
          CategoryListingFiltersState>(
        bloc: filtersCubit,
        listener: (context, state) {
          categoryListingCubit.fetch(state.toParams());
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CategoryListingFilterRow(),
              const SizedBox(height: 16),
              BlocBuilder(
                bloc: categoryListingCubit,
                builder: (context, state) {
                  if (state is CategoryListingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CategoryListingError) {
                    //TODO: needs to create a new widget to this case where it doesnt occupy the whole screen
                    return DefaultErrorWidget(
                      title: 'Ocorreu um erro ao buscar as categorias',
                      failure: state.failure,
                      description: '',
                      buttonLabel: 'Tentar novamente',
                      onPressed: () async => filtersCubit.reset(),
                    );
                  }
                  if (state is CategoryListingSuccess) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.categories.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return ContentBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: category.color,
                                      child: Icon(
                                        IconUtils.getIconByName(category.icon),
                                        color: AppColors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      category.name,
                                      style: typography.regular.large,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
