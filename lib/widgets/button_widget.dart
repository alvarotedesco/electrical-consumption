import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';

class AppButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;

  const AppButtonWidget({
    Key? key,
    required this.onPressed,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 60,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 0.7],
          colors: [
            AppColors.primary,
            AppColors.orange,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: SizedBox(
        height: 60,
        child: TextButton(
          onPressed: onPressed,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              texto,
              style: AppTextStyles.defaultStyleB,
            ),
          ]),
        ),
      ),
    );
  }
}
