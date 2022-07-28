import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/user/user_controller.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../themes/constants.dart';

class UserArea extends StatefulWidget {
  const UserArea({Key? key}) : super(key: key);

  @override
  State<UserArea> createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  UserController controller = UserController();

  String userMail = "teste@teste.com.br";
  String userName = "user name gigante";
  String userCPF = "123.456.789-10";

  Widget _infoUser(info) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(80),
        ),
        border: Border.fromBorderSide(
          BorderSide(
            color: AppColors.secondary,
            width: 2,
          ),
        ),
      ),
      child: Text(
        info,
        style: AppTextStyles.defaultStyleB,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    // TODO: fazer o get das informaçoes do Usuario
    // controller.getUserInfo().then((resp) {
    //   setState(() {
    //     userName = resp['name'];
    //     userCPF = resp['cpf'];
    //     userMail = resp['username'];
    //   });
    // });
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
          padding: EdgeInsets.all(20),
          child: Column(
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
                userName,
                style: AppTextStyles.userName,
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
                    _infoUser(userCPF),
                    SizedBox(height: 20),
                    _infoUser(userMail),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
