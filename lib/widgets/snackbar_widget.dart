import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  void showSnack(BuildContext context, String text, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: AppTextStyles.snackBar,
      ),
      backgroundColor: AppColors.white,
      duration: Duration(seconds: duration),
    ));
  }
}
