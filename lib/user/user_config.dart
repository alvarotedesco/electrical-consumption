import 'package:electrical_comsuption/models/user.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/user/user_controller.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/input_decoration_widget.dart';
import '../widgets/snackbar_widget.dart';

class UserConfig extends StatefulWidget {
  final UserController? data;

  const UserConfig({Key? key, this.data}) : super(key: key);

  @override
  State<UserConfig> createState() => _UserConfigState();
}

class _UserConfigState extends State<UserConfig> {
  final controller = UserController();
  final TextEditingController ctrlNewEmail = TextEditingController();
  final TextEditingController ctrlConfirmNewEmail = TextEditingController();

  final TextEditingController ctrlOldPassword = TextEditingController();
  final TextEditingController ctrlNewPassword = TextEditingController();
  final TextEditingController ctrlConfirmNewPassword = TextEditingController();

  bool editingEmail = true;
  bool canEditEmail = false;
  bool editingPassword = true;
  bool canEditPassword = false;
  bool passwordVisible = false;
  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: CustomAppBar(
          userArea: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      backgroundColor: AppColors.darkBlue,
                      title: Center(
                        child: Text(
                          Luvas.editingEmail,
                          style: AppTextStyles.h2WhiteBold,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      content: StatefulBuilder(
                        builder: (context, state) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InputDecorationWidget(
                              label: Luvas.newEmail,
                              controller: ctrlNewEmail,
                              style: AppTextStyles.h3WhiteBold,
                              textInputType: TextInputType.emailAddress,
                            ),
                            InputDecorationWidget(
                              label: Luvas.confirmNewEmail,
                              controller: ctrlConfirmNewEmail,
                              style: AppTextStyles.h3WhiteBold,
                              textInputType: TextInputType.emailAddress,
                            ),
                            InputDecorationWidget(
                              isPassword: true,
                              passwordVisible: passwordVisible,
                              controller: ctrlOldPassword,
                              label: Luvas.confirmPassword,
                              style: AppTextStyles.h3WhiteBold,
                              textInputType: TextInputType.text,
                              onPressed: () {
                                state(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        AppButtonWidget(
                          onPressed: () {
                            Navigator.pop(context);
                            ctrlNewEmail.text = '';
                            ctrlOldPassword.text = '';
                            ctrlConfirmNewEmail.text = '';
                          },
                          texto: Luvas.cancel,
                        ),
                        AppButtonWidget(
                          onPressed: () {
                            if (ctrlNewEmail.text == ctrlConfirmNewEmail.text) {
                              var data = UserModel(
                                cpf: widget.data!.user!.cpf,
                                name: widget.data!.user!.name,
                                password: ctrlOldPassword.text,
                                email: widget.data!.user!.email,
                                newEmail: ctrlConfirmNewEmail.text,
                                avatarUrl: widget.data!.user!.avatarUrl,
                              );

                              controller.updateUserV1Info(data).then((_) {
                                Navigator.pop(context);
                                ctrlNewEmail.text = '';
                                ctrlOldPassword.text = '';
                                ctrlConfirmNewEmail.text = '';
                                AppSnackBar().showSnack(
                                  context,
                                  "Email atualizado com sucesso!",
                                );
                              });
                            } else {
                              AppSnackBar().showSnack(
                                context,
                                "E-mails não correspodem! Tente novamente.",
                              );
                            }
                          },
                          texto: Luvas.save,
                        ),
                      ],
                    ),
                  );
                },
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
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      backgroundColor: AppColors.darkBlue,
                      title: Center(
                        child: Text(
                          Luvas.editingPassword,
                          style: AppTextStyles.h2WhiteBold,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      content: StatefulBuilder(
                        builder: (context, state) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InputDecorationWidget(
                              isPassword: true,
                              passwordVisible: oldPasswordVisible,
                              controller: ctrlOldPassword,
                              label: Luvas.confirmOldPassword,
                              style: AppTextStyles.h3WhiteBold,
                              textInputType: TextInputType.text,
                              onPressed: () {
                                state(() =>
                                    oldPasswordVisible = !oldPasswordVisible);
                              },
                            ),
                            InputDecorationWidget(
                              isPassword: true,
                              label: Luvas.newPassword,
                              controller: ctrlNewPassword,
                              style: AppTextStyles.h3WhiteBold,
                              textInputType: TextInputType.text,
                              passwordVisible: newPasswordVisible,
                              onPressed: () {
                                state(() {
                                  newPasswordVisible = !newPasswordVisible;
                                });
                              },
                            ),
                            InputDecorationWidget(
                              isPassword: true,
                              label: Luvas.confirmNewPassword,
                              style: AppTextStyles.h3WhiteBold,
                              controller: ctrlConfirmNewPassword,
                              textInputType: TextInputType.text,
                              passwordVisible: confirmPasswordVisible,
                              onPressed: () {
                                state(() {
                                  confirmPasswordVisible =
                                      !confirmPasswordVisible;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        AppButtonWidget(
                          onPressed: () {
                            Navigator.pop(context);
                            ctrlOldPassword.text = '';
                            ctrlNewPassword.text = '';
                            ctrlConfirmNewPassword.text = '';
                          },
                          texto: Luvas.cancel,
                        ),
                        AppButtonWidget(
                          onPressed: () {
                            if (ctrlNewPassword.text ==
                                ctrlConfirmNewPassword.text) {
                              var data = UserModel(
                                cpf: widget.data!.user!.cpf,
                                name: widget.data!.user!.name,
                                password: ctrlOldPassword.text,
                                email: widget.data!.user!.email,
                                avatarUrl: widget.data!.user!.avatarUrl,
                                newPassword: ctrlConfirmNewPassword.text,
                              );

                              controller.updateUserV1Info(data).then(
                                (_) {
                                  Navigator.pop(context);
                                  ctrlOldPassword.text = '';
                                  ctrlNewPassword.text = '';
                                  ctrlConfirmNewPassword.text = '';
                                  AppSnackBar().showSnack(
                                    context,
                                    "Senha atualizada com sucesso!",
                                  );
                                },
                              );
                            } else {
                              AppSnackBar().showSnack(
                                context,
                                "Senhas não correspodem! Tente novamente.",
                              );
                            }
                          },
                          texto: Luvas.save,
                        ),
                      ],
                    ),
                  );
                },
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
