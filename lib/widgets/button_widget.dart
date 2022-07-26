import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/widgets.dart';

class AppButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Alignment? alignment;
  final double? width;
  final Color? color;
  final String texto;
  final TextStyle? style;
  final bool leaving;
  final bool noRounded;

  const AppButtonWidget({
    Key? key,
    required this.onPressed,
    required this.texto,
    this.alignment,
    this.color,
    this.width,
    this.style,
    this.leaving = false,
    this.noRounded = false,
  }) : super(key: key);

  Widget ifLeaving() {
    if (leaving) {
      return ListTile(
        onTap: onPressed,
        leading: Icon(
          Icons.logout_rounded,
          color: AppColors.black,
          size: 25,
        ),
        title: Text(
          texto,
          style: style ?? AppTextStyles.defaultStyleB,
        ),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        child: Text(
          texto,
          style: style ?? AppTextStyles.defaultStyleB,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: width,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: !noRounded
            ? BorderRadius.all(
                Radius.circular(15),
              )
            : null,
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
      child: ifLeaving(),
    );
  }
}
