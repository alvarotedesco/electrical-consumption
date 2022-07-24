import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  void showSnack(BuildContext context, String text, {int duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        backgroundColor: AppColors.white,
        content: Text(
          text,
          style: AppTextStyles.snackBar,
        ),
      ),
    );
  }
}
