import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/user/user_config.dart';
import 'package:electrical_comsuption/user/user_controller.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../themes/constants.dart';
import 'user_state.dart';

class UserArea extends StatefulWidget {
  const UserArea({super.key});

  @override
  State<UserArea> createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  final UserController controller = UserController();

  String error = '';

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
                            _infoUser(controller.user!.email),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                runSpacing: 3,
                                spacing: 10,
                                children: [
                                  AppButtonWidget(
                                    color: AppColors.secondary,
                                    texto: 'Configurações',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserConfig(
                                            controller: controller,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  AppButtonWidget(
                                    color: AppColors.darkOrange,
                                    texto: 'Excluir conta',
                                    width: 145,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
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
