import 'package:electrical_comsuption/auth/auth_state.dart';
import 'package:electrical_comsuption/models/user.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';

import '../themes/constants.dart';
import 'auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController controller = AuthController();

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool passwordVisible = false;

  void _login() {
    var pass = passwordController.text.trim();
    var email = emailController.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      AppSnackBar().showSnack(context, "Preencha todos os campos!");
      return;
    }

    var user = UserModel(
      username: email,
      password: pass,
    );

    controller.login(user).then((value) {
      if (value['status'] == 'success') {
        Navigator.pushNamed(
          context,
          '/painel',
        );
      } else {
        AppSnackBar().showSnack(
          context,
          "Erro de Login, tente novamente mais tarde!",
        );
      }
    }).catchError((e) {
      AppSnackBar().showSnack(
        context,
        "Erro inesperado, de Login, tente novamente mais tarde!",
      );
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: controller.state == AuthState.loading
            ? Center(
                child: CircularProgressIndicator(color: AppColors.secondary),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputDecorationWidget(
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                      label: Luvas.email,
                    ),
                    InputDecorationWidget(
                      textInputType: TextInputType.text,
                      passwordVisible: passwordVisible,
                      controller: passwordController,
                      label: Luvas.password,
                      isPassword: true,
                      onPressed: () {
                        setState(() => passwordVisible = !passwordVisible);
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppButtonWidget(
                            texto: Luvas.btSignIn,
                            onPressed: _login,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                    Text(
                      Luvas.noAccount,
                      style: AppTextStyles.defaultStyleB,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppButtonWidget(
                            texto: Luvas.btSignUp,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/registry',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppButtonWidget(
                            texto: Luvas.btDemonstration,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/demo',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
