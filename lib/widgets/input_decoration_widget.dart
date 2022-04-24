import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputDecorationWidget extends StatelessWidget {
  final TextInputType? textInputType;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool passwordVisible;
  final VoidCallback? onPressed;
  final bool isPassword;

  const InputDecorationWidget(
      {Key? key,
      required this.textInputType,
      required this.label,
      this.inputFormatters,
      this.obscureText = false,
      this.onPressed,
      this.isPassword = false,
      this.passwordVisible = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !passwordVisible,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      style: const TextStyle(color: AppColors.white, fontSize: 20),
      decoration: InputDecoration(
        suffixIcon: Visibility(
          visible: isPassword,
          child: IconButton(
            icon: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: onPressed,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 6, color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 5, color: Color.fromARGB(255, 50, 15, 110)),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 3, color: Color.fromARGB(255, 50, 15, 110)),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
      ),
    );
  }
}
