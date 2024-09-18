import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const CircularProgressIndicator();
    }
    return CupertinoActivityIndicator(color: AppColors.red);
  }
}
