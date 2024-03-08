import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category_listing/category_listing_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing__filters_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filter_row.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filters_state.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';
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
    categoryListingCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Categorias'),
      body: BlocListener<CategoryListingFiltersCubit,
          CategoryListingFiltersState>(
        bloc: filtersCubit,
        listener: (context, state) {
          //TODO: call fetch using new and changed filters here
        },
        child: BlocBuilder<CategoryListingCubit, CategoryListingState>(
            bloc: categoryListingCubit,
            builder: (context, state) {
              if (state is CategoryListingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryListingError) {
                return DefaultErrorWidget(
                  title: 'Ocorreu um erro ao buscar as categorias',
                  failure: state.failure,
                  description: '',
                  buttonLabel: 'Tentar novamente',
                  onPressed: () async {
                    //TODO: add reset and fetch function in here
                  },
                );
              }
              if (state is CategoryListingSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const CategoryListingFilterRow(),
                      ...state.categories.map((category) {
                        return Text(category.name);
                      }),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
