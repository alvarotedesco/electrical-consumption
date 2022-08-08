import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/user/user_controller.dart';
import 'package:electrical_comsuption/widgets/box_widget.dart';
import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/constants.dart';
import '../widgets/custom_app_bar.dart';

class UserConfig extends StatefulWidget {
  final UserController controller;

  const UserConfig({
    required this.controller,
    super.key,
  });

  @override
  State<UserConfig> createState() => _UserConfigState();
}

class _UserConfigState extends State<UserConfig> {
  final TextEditingController ctrlNewEmail = TextEditingController();
  final TextEditingController ctrlConfirmNewEmail = TextEditingController();

  final TextEditingController ctrlOldPassword = TextEditingController();
  final TextEditingController ctrlNewPassword = TextEditingController();
  final TextEditingController ctrlConfirmNewPassword = TextEditingController();

  bool editingEmail = true;
  bool editingPassword = true;
  bool passwordVisible = false;
  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: CustomAppBar(userArea: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => BoxDialog(context: context)
                    .userConfigEmail(widget.controller),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: Icon(
                        color: AppColors.white60,
                        Icons.mode_edit_outline_outlined,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 7, top: 10, bottom: 10),
                        child: Text(
                          Luvas.editEmail,
                          style: AppTextStyles.h1WhiteBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 2,
                indent: 5,
                thickness: 1,
                endIndent: 5,
                color: AppColors.grey,
              ),
              GestureDetector(
                onTap: () => BoxDialog(context: context)
                    .userConfigPassword(widget.controller),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: Icon(
                        color: AppColors.white60,
                        Icons.password_rounded,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 7, top: 10, bottom: 10),
                        child: Text(
                          Luvas.editPassword,
                          style: AppTextStyles.h1WhiteBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 2,
                indent: 5,
                thickness: 1,
                endIndent: 5,
                color: AppColors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
