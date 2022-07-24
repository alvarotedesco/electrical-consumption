import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/container/containers.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/models/user.dart';
import '../demo/demonstration_page.dart';
import 'package:flutter/material.dart';
import '../themes/constants.dart';
import 'sign_up.dart';
import '../api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

    doLogin(Underwear.loginURL, user).then((value) {
      if (value['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Containers(),
          ),
        );
      } else {
        AppSnackBar()
            .showSnack(context, "Erro de Login, tente novamente mais tarde!");
      }
    }).catchError((e) {
      AppSnackBar().showSnack(
          context, "Erro inesperado, de Login, tente novamente mais tarde!");
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Meias.imges),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Container(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
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
              AppButtonWidget(
                texto: Luvas.btSignIn,
                onPressed: _login,
              ),
              SizedBox(height: 80),
              Text(
                Luvas.noAccount,
                style: AppTextStyles.defaultStyleB,
                textAlign: TextAlign.center,
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
