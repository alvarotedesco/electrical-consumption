import 'package:electrical_comsuption/api.dart';
import 'package:electrical_comsuption/login_page.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'themes/luvas.dart';

class UserArea extends StatefulWidget {
  const UserArea({Key? key}) : super(key: key);

  @override
  State<UserArea> createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  String userName = "user";
  String userMail = "Email";
  String userCPF = "405.560.458-07";

  void getDatas() async {
    var data = await getData(Underwear.getUserDataURL);

    setState(() {
      userName = data['name'];
      userCPF = data['cpf'];
      userMail = data['email'];
    });
  }

  @override
  void initState() {
    super.initState();

    getDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voltar'),
        backgroundColor: Colors.black54,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            })),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(25, 70, 25, 25),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Meias.imges), fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              const Center(
                child: CircleAvatar(
                  child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      backgroundImage: AssetImage(Meias.teste),
                      // TODO: Quando nao pegar a imagem / criar função
                      radius: 90),
                  radius: 100,
                  backgroundColor: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Thiago Luiz Rizzo Parrilo Souza Oliveira Ribeiro Anjo",
                style: AppTextStyles.userName,
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white60,
                ),
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color: AppColors.transparent,
                        border: Border.fromBorderSide(
                          BorderSide(color: AppColors.secondary, width: 2),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(80))),
                    child: Text(userCPF, style: AppTextStyles.defaultStyleB),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(color: AppColors.secondary, width: 2),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(80))),
                    child: Text(
                      userMail,
                      style: AppTextStyles.defaultStyleB,
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
