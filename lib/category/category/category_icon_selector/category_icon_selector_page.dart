import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category/category_form_cubit.dart';
import 'package:hermes_app/category/category/category_icon_selector/category_icon_selector_cubit.dart';
import 'package:hermes_app/category/category/category_icon_selector/category_icon_selector_state.dart';
import 'package:hermes_app/shared/entities/nullable_model.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/default_app_bar/default_app_bar.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/default_error_widget.dart';
import 'package:hermes_app/shared/widgets/default_error_widget/register_error_cubit.dart';

class CategoryIconSelectorPage extends StatefulWidget {
  const CategoryIconSelectorPage({super.key});

  @override
  State<CategoryIconSelectorPage> createState() =>
      _CategoryIconSelectorPageState();
}

class _CategoryIconSelectorPageState extends State<CategoryIconSelectorPage> {
  final categoryIconSelectorCubit = Modular.get<CategoryIconSelectorCubit>();
  final registerErrorCubit = Modular.get<RegisterErrorCubit>();
  final formCubit = Modular.get<CategoryFormCubit>();

  @override
  void initState() {
    categoryIconSelectorCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Selecionar ícone',
      ),
      body: BlocBuilder<CategoryIconSelectorCubit, CategoryIconSelectorState>(
        bloc: categoryIconSelectorCubit,
        builder: (context, state) {
          if (state is CategoryIconSelectorLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.darkGrey,
              ),
            );
          }
          if (state is CategoryIconSelectorError) {
            return DefaultErrorWidget(
              title: 'Ocorreu um erro ao buscar os ícones',
              failure: state.failure,
              description: 'Clique no botão para tentar novamente',
              buttonLabel: 'Tentar novamente',
              onPressed: () async {
                categoryIconSelectorCubit.fetch();
              },
            );
          }
          if (state is CategoryIconSelectorSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: state.iconSegments.length,
              itemBuilder: (context, index) {
                final iconSegment = state.iconSegments[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      iconSegment.title,
                      style: typography.regular.medium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      runSpacing: 8,
                      children: iconSegment.icons.map((icon) {
                        final isSelected = formCubit.category.icon == icon;
                        return Container(
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.grey : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              formCubit.change(icon: Nullable(icon));
                              Modular.to.pop();
                            },
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: formCubit.category.color ??
                                  AppColors.lightGrey,
                              child: Icon(
                                icon,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
