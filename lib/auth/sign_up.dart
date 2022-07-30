import 'package:brasil_fields/brasil_fields.dart';
import 'package:electrical_comsuption/auth/auth_controller.dart';
import 'package:electrical_comsuption/auth/auth_state.dart';
import 'package:electrical_comsuption/models/user.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/constants.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/custom_app_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController controller = AuthController();

  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final userCPFController = TextEditingController();
  final emailController = TextEditingController();
  bool passwordVisible = false;

  void _registry() {
    var name = usernameController.text.trim();
    var email = emailController.text.trim();
    var pass = passwordController.text.trim();
    var cpf =
        userCPFController.text.replaceAll(".", "").replaceAll("-", "").trim();

    if (name.isEmpty || cpf.isEmpty || email.isEmpty || pass.isEmpty) {
      AppSnackBar().showSnack(context, "Preencha todos os campos!");
      return;
    }

    if (cpf.length < 11) {
      AppSnackBar().showSnack(context, "Preencha o CPF corretamente");
      return;
    }

    UserModel user = UserModel(
      username: email,
      password: pass,
      name: name,
      cpf: cpf,
    );

    controller.registry(user).then((value) {
      if (value['status'] == 'success') {
        Navigator.pushNamed(context, '/painel');
      } else {
        AppSnackBar().showSnack(
          context,
          "Erro ao registrar, tente novamente mais tarde!",
        );
      }
    }).catchError((e) {
      AppSnackBar().showSnack(
        context,
        "Erro inesperado, de Registro, tente novamente mais tarde!",
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
        appBar: CustomAppBar(
          label: 'Cadastrar',
          noAuth: true,
        ),
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
                      textInputType: TextInputType.text,
                      controller: usernameController,
                      label: Luvas.username,
                    ),
                    InputDecorationWidget(
                      textInputType: TextInputType.number,
                      controller: userCPFController,
                      label: Luvas.cpf,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                    ),
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
                            texto: Luvas.btSigningUp,
                            onPressed: _registry,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
