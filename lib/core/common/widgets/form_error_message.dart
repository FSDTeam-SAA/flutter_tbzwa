import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';


class FormErrorMessage extends StatelessWidget {
  final String message;

  const FormErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();

    return Text(
      message,
      style: TextStyle(
        color: AppColors.red,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
