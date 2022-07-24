import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/api.dart';
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

    getData(Underwear.getUserDataURL).then((resp) {
      setState(() {
        userName = resp['name'];
        userCPF = resp['cpf'];
        userMail = resp['username'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Voltar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 140, 25, 25),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundColor: AppColors.secondary,
                  radius: 100,
                  child: CircleAvatar(
                    radius: 90,
                    backgroundImage: AssetImage(Meias.teste),
                    backgroundColor: AppColors.primary,
                    // TODO: Quando nao pegar a imagem / criar função
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                userName,
                style: AppTextStyles.userName,
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.black60,
                ),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        userCPF,
                        style: AppTextStyles.defaultStyleB,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.transparent,
                        border: Border.fromBorderSide(
                          BorderSide(
                            color: AppColors.secondary,
                            width: 2,
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(80),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        userMail,
                        style: AppTextStyles.defaultStyleB,
                      ),
                      decoration: const BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(
                            color: AppColors.secondary,
                            width: 2,
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(80),
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
