import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle defaultStyleB = TextStyle(
    fontFamily: "Montserrat",
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle defaultStyle = TextStyle(
    fontFamily: "Montserrat",
    color: AppColors.white,
    fontSize: 20,
  );

  static const TextStyle snackBar = TextStyle(
    fontFamily: "Montserrat",
    color: AppColors.red,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle userName = TextStyle(
    fontFamily: "Montserrat",
    color: AppColors.white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle defaultWarning = TextStyle(
    fontFamily: "Montserrat",
    color: AppColors.primary,
    fontSize: 25,
  );
}
