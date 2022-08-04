import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/user/user_controller.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/floating_button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/constants.dart';
import 'user_state.dart';

class UserArea extends StatefulWidget {
  const UserArea({super.key});

  @override
  State<UserArea> createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  final controller = UserController();
  final TextEditingController controllerInputEmail1 = TextEditingController();
  final TextEditingController controllerInputEmail2 = TextEditingController();
  bool canEdit = false;
  String error = '';
  bool isSelected = false;

  Widget _infoUser(info, {email = false, selected = false}) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: selected ? AppColors.secondary : AppColors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(80)),
        border: Border.fromBorderSide(
          BorderSide(
            color: AppColors.secondary,
            width: 2,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (selected)
            Center(
              child: Icon(
                Icons.check,
                size: 45,
                color: AppColors.white,
              ),
            )
          else
            Row(
              children: [
                if (email)
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.mail_outline_rounded,
                      color: AppColors.white60,
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.white60,
                    ),
                  ),
                Text(
                  info,
                  style: AppTextStyles.h1WhiteBold,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _errorWidget() {
    return controller.state == UserState.error
        ? Center(child: Text(error))
        : controller.state == UserState.loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.secondary,
                ),
              )
            : Center(child: Text('falha'));
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    // TODO: fazer o get das informaçoes do Usuario
    controller.getUserInfo().then((value) => error = value['data'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: CustomAppBar(
          userArea: true,
        ),
        floatingActionButton: FloatingCustomButtonWidget(
          selected: isSelected,
          canCreate: false,
          delete: false,
          onEditButton: (() => {
                setState(() => {
                      canEdit = !canEdit,
                    }),
              }),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: controller.state != UserState.success
                ? _errorWidget()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: AppColors.secondary,
                          radius: 95,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(Meias.teste),
                            backgroundColor: AppColors.primary,
                            radius: 90,
                            // TODO: Quando nao pegar a imagem / criar função
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        controller.user!.name as String,
                        style: AppTextStyles.whiteBold28,
                      ),
                      SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.black60,
                        ),
                        child: Column(
                          children: [
                            _infoUser(controller.user!.cpf),
                            SizedBox(height: 20),
                            GestureDetector(
                              onLongPress: () => {
                                setState(() => {
                                      if (canEdit) canEdit != canEdit,
                                      isSelected = !isSelected,
                                    })
                              },
                              child: _infoUser(
                                controller.user!.email,
                                email: true,
                                selected: isSelected,
                              ),
                            ),
                            SizedBox(height: 20),
                            Visibility(
                              visible: canEdit,
                              child: Column(
                                children: [
                                  InputDecorationWidget(
                                    controller: controllerInputEmail1,
                                    label: 'Novo e-mail',
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 20),
                                  InputDecorationWidget(
                                    controller: controllerInputEmail1,
                                    label: 'Confirmar novo e-mail',
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButtonWidget(
                                  onPressed: () => {},
                                  texto: 'Excluir conta',
                                  color: AppColors.darkOrange,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
