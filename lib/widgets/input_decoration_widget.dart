import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputDecorationWidget extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final void Function(String)? onSubmited;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final VoidCallback? onPressed;
  final bool passwordVisible;
  final TextStyle? style;
  final bool isPassword;
  final String? label;

  const InputDecorationWidget({
    super.key,
    this.passwordVisible = false,
    required this.textInputType,
    required this.controller,
    this.isPassword = false,
    this.inputFormatters,
    required this.label,
    this.onSubmited,
    this.onPressed,
    this.onChanged,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: isPassword ? !passwordVisible : false,
          style: AppTextStyles.defaultStyle,
          inputFormatters: inputFormatters,
          onFieldSubmitted: onSubmited,
          keyboardType: textInputType,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelStyle: style ?? AppTextStyles.defaultStyleB,
            labelText: label,
            contentPadding:
                EdgeInsets.only(left: 20, right: isPassword ? 0 : 20),
            suffixIcon: isPassword
                ? Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  )
                : null,
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
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
