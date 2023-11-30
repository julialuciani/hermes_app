import 'package:flutter/material.dart';
import 'package:hermes_app/shared/widgets/loading_widgets/loading_box.dart';
import 'package:hermes_app/shared/widgets/loading_widgets/loading_chart.dart';

class DefaultLoadingScreen extends StatelessWidget {
  const DefaultLoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const LoadingChart(),
          const SizedBox(height: 48),
          ...List.generate(
            10,
            (index) => Column(
              children: const [
                LoadingBox(height: 80),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
