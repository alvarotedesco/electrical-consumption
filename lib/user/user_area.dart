import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/api.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../themes/constants.dart';

class UserArea extends StatefulWidget {
  const UserArea({Key? key}) : super(key: key);

  @override
  State<UserArea> createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  String userMail = "teste@teste.com.br";
  String userName = "user name gigante";
  String userCPF = "123.456.789-10";

  @override
  void initState() {
    super.initState();

    // getData(Underwear.getUserDataURL).then((resp) {
    //   setState(() {
    //     userName = resp['name'];
    //     userCPF = resp['cpf'];
    //     userMail = resp['username'];
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 140, 25, 25),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: AppColors.secondary,
                  radius: 100,
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
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        userCPF,
                        style: AppTextStyles.defaultStyleB,
                      ),
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        userMail,
                        style: AppTextStyles.defaultStyleB,
                      ),
                      decoration: BoxDecoration(
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
                    ),
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
