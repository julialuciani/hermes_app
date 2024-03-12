import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category_listing/category_listing_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing__filters_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filter_row.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filters_state.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';
import 'package:hermes_app/category/category_listing/widgets/category_list_widget.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
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
                      child: CategoryListWidget(
                        categories: state.categories,
                        onTap: (index) {
                          //TODO: add navigation to category form page
                        },
                        onRemove: (index) {
                          //TODO: show confirmation dialog and remove based on answer
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
