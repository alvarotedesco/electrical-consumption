import 'package:electrical_comsuption/api.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/user_area.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'demonstration_page.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'themes/luvas.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String noacc = "Não tem uma conta?";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(Meias.imges), fit: BoxFit.cover),
      ),
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
                controller: emailController,
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
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              AppButtonWidget(
                texto: Luvas.btSignIn,
                onPressed: () {
                  if (emailController.text.trim().isEmpty ||
                      passwordController.text.trim().isEmpty) {
                    AppSnackBar()
                        .showSnack(context, "Preencha todos os campos!", 2);
                    return;
                  }

                  var email = emailController.text.trim();
                  var pass = passwordController.text.trim();

                  Map<String, String> data = {
                    "username": email,
                    "password": pass
                  };

                  postData(Underwear.loginURL, data).then((value) {
                    value.forEach((k, v) {
                      if (k == "token") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserArea(),
                          ),
                        );
                      } else {
                        // TODO
                      }
                    });
                  });
                },
              ),
              const SizedBox(height: 80),
              const SizedBox(
                height: 20,
                child: Text(
                  Luvas.noAccount,
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
                    ),
                  );
                },
              ),
              AppButtonWidget(
                texto: Luvas.btDemonstration,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Demonstration(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
