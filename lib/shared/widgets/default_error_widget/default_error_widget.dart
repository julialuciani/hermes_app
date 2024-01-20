import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';
import 'package:hermes_app/shared/theme/app_colors.dart';
import 'package:hermes_app/shared/widgets/default_button/default_button.dart';

class DefaultErrorWidget extends StatefulWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final Future<void> Function() onPressed;
  const DefaultErrorWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<DefaultErrorWidget> createState() => _DefaultErrorWidgetState();
}

class _DefaultErrorWidgetState extends State<DefaultErrorWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Spacer(),
          Image.asset('assets/images/error.png'),
          const SizedBox(height: 48),
          Text(
            widget.title,
            style: context.typography.bold.large.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: context.typography.paragraph.medium.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
          const Spacer(),
          DefaultButton(
            isLoading: isLoading,
            onPressed: () async {
              setState(() => isLoading = true);
              widget.onPressed().then((_) {
                setState(() => isLoading = false);
              });
            },
            title: Text(
              widget.buttonLabel,
            ),
          ),
        ],
      ),
    );
  }
}
