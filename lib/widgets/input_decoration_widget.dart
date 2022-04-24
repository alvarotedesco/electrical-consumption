import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputDecorationWidget extends StatelessWidget {
  final TextInputType? textInputType;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final bool passwordVisible;
  final VoidCallback? onPressed;
  final bool isPassword;
  final TextEditingController? controller;

  const InputDecorationWidget({
    Key? key,
    required this.controller,
    required this.label,
    required this.textInputType,
    this.inputFormatters,
    this.onPressed,
    this.isPassword = false,
    this.passwordVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ? !passwordVisible : false,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      controller: controller,
      style: AppTextStyles.defaultStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 30),
        labelText: label,
        labelStyle: AppTextStyles.defaultStyleB,
        suffixIcon: Visibility(
          visible: isPassword,
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: onPressed,
            ),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: AppColors.primary),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 5, color: AppColors.primary),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 6, color: AppColors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
      ),
    );
  }
}
