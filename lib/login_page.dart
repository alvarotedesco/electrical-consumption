import 'package:electrical_comsuption/API.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'demonstration.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'themes/luvas.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  String noacc = "nao tem acocondnas?";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Meias.imges), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Container(
          padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              InputDecorationWidget(
                textInputType: TextInputType.emailAddress,
                controller: userController,
                label: Luvas.email,
              ),
              const SizedBox(height: 10),
              InputDecorationWidget(
                textInputType: TextInputType.text,
                label: Luvas.password,
                passwordVisible: passwordVisible,
                controller: passwordController,
                isPassword: true,
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              AppButtonWidget(
                texto: Luvas.btSignIn,
                onPressed: () {
                  if (userController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Preencha todos os campos!"),
                      backgroundColor: AppColors.white,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }

                  Map<String, String> data = {
                    "username": "${userController.text}",
                    "password": "${passwordController.text}"
                  };

                  postData(Underwear.loginURL, data).then((value) {
                    setState(() {
                      noacc = value.toString();
                    });
                  });
                },
              ),
              const SizedBox(height: 80),
              SizedBox(
                height: 20,
                child: Text(
                  noacc,
                  style: AppTextStyles.defaultStyleB,
                  textAlign: TextAlign.center,
                ),
              ),
              AppButtonWidget(
                  texto: Luvas.btSignUp,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                  }),
              AppButtonWidget(
                  texto: Luvas.btDemonstration,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Demonstration(),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
