import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/user/user_controller.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/floating_button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';

import '../themes/constants.dart';
import 'user_state.dart';

class UserArea extends StatefulWidget {
  const UserArea({super.key});

  @override
  State<UserArea> createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  final controller = UserController();
  final TextEditingController controllerInputName = TextEditingController();
  final TextEditingController controllerInputEmail = TextEditingController();
  String error = '';
  bool selected = false;

  Widget _infoUser(info, {email = false}) {
    if (email) {
      return GestureDetector(
        onTap: () => {
          setState(() => {
                selected = !selected,
              })
        },
        child: Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(80)),
            border: Border.fromBorderSide(
              BorderSide(
                color: AppColors.secondary,
                width: 2,
              ),
            ),
          ),
          child: Text(
            info,
            style: AppTextStyles.h1WhiteBold,
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(80)),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.secondary,
              width: 2,
            ),
          ),
        ),
        child: Text(
          info,
          style: AppTextStyles.h1WhiteBold,
        ),
      );
    }
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
          selected: selected,
          canCreate: false,
          canDelete: false,
          onEditButton: (() => {}),
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
                            Visibility(
                              visible: selected,
                              child: _infoUser(
                                controller.user!.email,
                                email: true,
                              ),
                            ),
                            SizedBox(height: 20),
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
