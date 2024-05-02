import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hermes_app/category/category_routes.dart';
import 'package:hermes_app/home/widgets/menu_item.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Menu',
                style: typography.bold.extraLarge,
              ),
              const SizedBox(height: 20),
              MenuItem(
                icon: Icons.mail,
                text: 'Categoria',
                onPressed: () {
                  Modular.to.popAndPushNamed(CategoryRoutes.categoryListing);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
