import 'package:electrical_comsuption/api.dart';
import 'package:electrical_comsuption/login_page.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:brasil_fields/brasil_fields.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordVisible = false;

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final userCPFController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voltar'),
        backgroundColor: AppColors.black60,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Voltar',
            onPressed: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            })),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            InputDecorationWidget(
              controller: usernameController,
              textInputType: TextInputType.text,
              label: Luvas.username,
            ),
            const SizedBox(height: 10),
            InputDecorationWidget(
              controller: userCPFController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
              textInputType: TextInputType.number,
              label: Luvas.cpf,
            ),
            const SizedBox(height: 10),
            InputDecorationWidget(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              label: Luvas.email,
            ),
            const SizedBox(height: 10),
            InputDecorationWidget(
              controller: passwordController,
              isPassword: true,
              passwordVisible: passwordVisible,
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              textInputType: TextInputType.text,
              label: Luvas.password,
            ),
            const SizedBox(height: 10),
            AppButtonWidget(
              texto: Luvas.btSigningUp,
              onPressed: () {
                if (usernameController.text.trim().isEmpty ||
                    userCPFController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty ||
                    passwordController.text.trim().isEmpty) {
                  AppSnackBar()
                      .showSnack(context, "Preencha todos os campos!", 2);
                  return;
                }
                var name = usernameController.text.trim();
                var cpf = userCPFController.text
                    .replaceAll(".", "")
                    .replaceAll("-", "")
                    .trim();
                var email = emailController.text.trim();
                var pass = passwordController.text.trim();

                if (cpf.length < 11) {
                  AppSnackBar()
                      .showSnack(context, "Preencha o CPF corretamente", 2);
                  return;
                }

                Map<String, String> data = {
                  "name": name,
                  "cpf": cpf,
                  "username": email,
                  "password": pass
                };

                postData(Underwear.registryURL, data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
