import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hermes_app/category/category_listing/category_listing_cubit.dart';
import 'package:hermes_app/category/category_listing/category_listing_filter/category_listing_filter_modal.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';
import 'package:hermes_app/shared/widgets/input/input.dart';

class CategoryListingPage extends StatefulWidget {
  const CategoryListingPage({super.key});

  @override
  State<CategoryListingPage> createState() => _CategoryListingPageState();
}

class _CategoryListingPageState extends State<CategoryListingPage> {
  final categoryListingCubit = Modular.get<CategoryListingCubit>();

  @override
  void initState() {
    categoryListingCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Categorias'),
      body: BlocBuilder<CategoryListingCubit, CategoryListingState>(
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
                    Row(
                      children: [
                        const Expanded(
                          child: Input(
                            suffixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  const CategoryListingFilterModal(),
                            );
                          },
                          child: Container(
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
                          ),
                        ),
                      ],
                    ),
                    ...state.categories.map((category) {
                      return Text(category.name);
                    }),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
