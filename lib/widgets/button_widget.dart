import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Alignment? alignment;
  final TextStyle? style;
  final double? width;
  final Color? color;
  final String texto;

  const AppButtonWidget({
    required this.onPressed,
    required this.texto,
    this.alignment,
    this.color,
    this.width,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: width,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        gradient: color == null
            ? LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                stops: const [0.35, 1],
                colors: const [
                  AppColors.primary,
                  AppColors.secondary,
                ],
              )
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          texto,
          style: style ?? AppTextStyles.h1WhiteBold,
        ),
      ),
    );
  }
}
