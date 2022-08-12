import 'package:electrical_comsuption/device/device_controller.dart';
import 'package:electrical_comsuption/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import '../principal/principal_controller.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../themes/constants.dart';
import '../user/user_controller.dart';
import 'button_widget.dart';
import 'input_decoration_widget.dart';
import 'snackbar_widget.dart';

class BoxDialog {
  BuildContext context;

  BoxDialog({
    required this.context,
  });

  Future<dynamic> clickOnDevice(PrincipalController controller, int index) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        int timeControl2 = 0;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.white, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.darkBlue,
          title: Center(
            child: Text(
              controller.containerDevices[index].name,
              style: AppTextStyles.h2WhiteBold,
            ),
          ),
          actions: [
            AppButtonWidget(
              onPressed: () {
                controller.makeDataToSave();
                Navigator.pop(context, timeControl2);
              },
              texto: "Ok",
              color: AppColors.primary,
              style: AppTextStyles.h2WhiteBold,
            )
          ],
          content: StatefulBuilder(
            builder: (context, state) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var ind = 0; ind < 2; ind++) ...[
                      Radio<int>(
                        activeColor: AppColors.secondary,
                        value: ind,
                        groupValue: timeControl2,
                        onChanged: (val) {
                          state(() {
                            timeControl2 = val as int;
                          });
                        },
                      ),
                      if (ind == 0)
                        Text(
                          "Horas",
                          style: AppTextStyles.h3WhiteBold,
                        ),
                      if (ind == 1)
                        Text(
                          "Minutos",
                          style: AppTextStyles.h3WhiteBold,
                        ),
                    ],
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: InputDecorationWidget(
                        controller: controller.hoursControllers[index],
                        textStyle: AppTextStyles.h2WhiteBold,
                        textInputType: TextInputType.number,
                        style: AppTextStyles.h2WhiteBold,
                        label: 'Tempo de uso',
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        onChanged: (tex) {
                          if (tex != "" &&
                              timeControl2 == 0 &&
                              int.parse(tex) >= 24) {
                            controller.hoursControllers[index].text = '24';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InputDecorationWidget(
                        controller: controller.daysControllers[index],
                        textStyle: AppTextStyles.h2WhiteBold,
                        textInputType: TextInputType.number,
                        style: AppTextStyles.h2WhiteBold,
                        label: "Dias de uso",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        onChanged: (tex) {
                          if (tex != "") {
                            if (int.parse(tex) >= 99) {
                              controller.daysControllers[index].text = '99';
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InputDecorationWidget(
                        controller: controller.qtdControllers[index],
                        textStyle: AppTextStyles.h2WhiteBold,
                        textInputType: TextInputType.number,
                        style: AppTextStyles.h2WhiteBold,
                        label: "Quantidade",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onChanged: (tex) {
                          if (tex != "") {
                            if (int.parse(tex) >= 999) {
                              controller.qtdControllers[index].text = '999';
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> editDevice(
    DeviceController controller, {
    DeviceModel? device,
  }) {
    TextEditingController nameController = TextEditingController();
    TextEditingController powerController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.white, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.darkBlue,
          title: Center(
            child: Text(
              device != null ? 'Editar Dispositivo' : 'Novo Dispositivo',
              style: AppTextStyles.h2WhiteBold,
            ),
          ),
          actions: [
            AppButtonWidget(
              onPressed: () {
                if (powerController.text.trim().isEmpty ||
                    nameController.text.trim().isEmpty) {
                  AppSnackBar().showSnack(context, "Preencha todos os campos!");
                  return;
                }

                Navigator.pop(
                    context, [nameController.text, powerController.text]);
              },
              texto: "Ok",
              color: AppColors.primary,
              style: AppTextStyles.h2WhiteBold,
            ),
            AppButtonWidget(
              onPressed: () {
                Navigator.pop(context, []);
              },
              texto: "Cancelar",
              color: AppColors.primary,
              style: AppTextStyles.h2WhiteBold,
            ),
          ],
          content: StatefulBuilder(
            builder: (context, state) {
              if (device != null) {
                state(() {
                  powerController.text = device.power.toString();
                  nameController.text = device.name;
                });
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputDecorationWidget(
                    textInputType: TextInputType.name,
                    style: AppTextStyles.h1WhiteBold,
                    controller: nameController,
                    label: Luvas.nameDevice,
                  ),
                  InputDecorationWidget(
                    textInputType: TextInputType.number,
                    style: AppTextStyles.h1WhiteBold,
                    controller: powerController,
                    label: Luvas.powerDevice,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<dynamic> userConfigEmail(
    UserController controller, {
    DeviceModel? device,
  }) {
    final TextEditingController ctrlNewEmail = TextEditingController();
    final TextEditingController ctrlConfirmNewEmail = TextEditingController();

    final TextEditingController ctrlOldPassword = TextEditingController();

    bool passwordVisible = false;

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        backgroundColor: AppColors.darkBlue,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Center(
          child: Text(
            Luvas.editingEmail,
            style: AppTextStyles.h2WhiteBold,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputDecorationWidget(
                textInputType: TextInputType.emailAddress,
                style: AppTextStyles.h3WhiteBold,
                controller: ctrlNewEmail,
                label: Luvas.newEmail,
              ),
              InputDecorationWidget(
                textInputType: TextInputType.emailAddress,
                style: AppTextStyles.h3WhiteBold,
                controller: ctrlConfirmNewEmail,
                label: Luvas.confirmNewEmail,
              ),
              InputDecorationWidget(
                textInputType: TextInputType.text,
                passwordVisible: passwordVisible,
                style: AppTextStyles.h3WhiteBold,
                label: Luvas.confirmPassword,
                controller: ctrlOldPassword,
                isPassword: true,
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
            texto: Luvas.cancel,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          AppButtonWidget(
            texto: Luvas.save,
            onPressed: () {
              if (ctrlNewEmail.text == ctrlConfirmNewEmail.text) {
                var data = UserModel(
                  cpf: controller.user!.cpf,
                  name: controller.user!.name,
                  password: ctrlOldPassword.text,
                  email: controller.user!.email,
                  newEmail: ctrlConfirmNewEmail.text,
                  avatarUrl: controller.user!.avatarUrl,
                );

                controller.updateUserV1Info(data).then(
                  (resp) {
                    if (resp['status'] == 'error') {
                      AppSnackBar().showSnack(
                        context,
                        "Senha atual inserida incorreta!",
                      );
                    } else {
                      Navigator.pop(context);
                      AppSnackBar().showSnack(
                        context,
                        "E-mails alterado com sucesso!.",
                      );
                    }
                  },
                );
              } else {
                AppSnackBar().showSnack(
                  context,
                  "E-mails não correspodem! Tente novamente.",
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> userConfigPassword(
    UserController controller, {
    DeviceModel? device,
  }) {
    final TextEditingController ctrlOldPassword = TextEditingController();
    final TextEditingController ctrlNewPassword = TextEditingController();
    final TextEditingController ctrlConfirmNewPassword =
        TextEditingController();

    bool oldPasswordVisible = false;
    bool newPasswordVisible = false;
    bool confirmPasswordVisible = false;

    return showDialog(
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
                passwordVisible: oldPasswordVisible,
                textInputType: TextInputType.text,
                style: AppTextStyles.h3WhiteBold,
                label: Luvas.confirmOldPassword,
                controller: ctrlOldPassword,
                isPassword: true,
                onPressed: () {
                  state(() => oldPasswordVisible = !oldPasswordVisible);
                },
              ),
              InputDecorationWidget(
                passwordVisible: newPasswordVisible,
                textInputType: TextInputType.text,
                style: AppTextStyles.h3WhiteBold,
                controller: ctrlNewPassword,
                label: Luvas.newPassword,
                isPassword: true,
                onPressed: () {
                  state(() {
                    newPasswordVisible = !newPasswordVisible;
                  });
                },
              ),
              InputDecorationWidget(
                passwordVisible: confirmPasswordVisible,
                controller: ctrlConfirmNewPassword,
                textInputType: TextInputType.text,
                style: AppTextStyles.h3WhiteBold,
                label: Luvas.confirmNewPassword,
                isPassword: true,
                onPressed: () {
                  state(() {
                    confirmPasswordVisible = !confirmPasswordVisible;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          AppButtonWidget(
            texto: Luvas.cancel,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          AppButtonWidget(
            texto: Luvas.save,
            onPressed: () {
              if (ctrlNewPassword.text == ctrlConfirmNewPassword.text) {
                var data = UserModel(
                  cpf: controller.user!.cpf,
                  name: controller.user!.name,
                  password: ctrlOldPassword.text,
                  email: controller.user!.email,
                  avatarUrl: controller.user!.avatarUrl,
                  newPassword: ctrlConfirmNewPassword.text,
                );

                controller.updateUserV1Info(data).then(
                  (resp) {
                    if (resp['status'] == 'error') {
                      AppSnackBar().showSnack(
                        context,
                        "Senha atual inserida incorreta!",
                      );
                    } else {
                      Navigator.pop(context);
                      AppSnackBar().showSnack(
                        context,
                        "Senha atualizada com sucesso!",
                      );
                    }
                  },
                );
              } else {
                AppSnackBar().showSnack(
                  context,
                  "Senhas não correspodem! Tente novamente.",
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
