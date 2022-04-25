import 'package:electrical_comsuption/API.dart';
import 'package:electrical_comsuption/login_page.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
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
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Voltar',
            onPressed: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            })),
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Meias.imges), fit: BoxFit.cover)),
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            InputDecorationWidget(
                controller: usernameController,
                textInputType: TextInputType.text,
                label: Luvas.username),
            const SizedBox(height: 10),
            InputDecorationWidget(
                controller: userCPFController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                textInputType: TextInputType.number,
                label: Luvas.cpf),
            const SizedBox(height: 10),
            InputDecorationWidget(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                label: Luvas.email),
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
                label: Luvas.password),
            const SizedBox(height: 10),
            AppButtonWidget(
              texto: Luvas.btSigningUp,
              onPressed: () {
                if (usernameController.text.isEmpty ||
                    userCPFController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Preencha todos os campos!",
                        style: AppTextStyles.defaultWarning,
                      ),
                      backgroundColor: AppColors.white,
                      duration: Duration(seconds: 3),
                    ),
                  );
                  return;
                }

                Map<String, String> data = {
                  "name": "${usernameController.text}",
                  "cpf":
                      "${userCPFController.text.replaceAll(".", "").replaceAll("-", "")}",
                  "username": "${emailController.text}",
                  "password": "${passwordController.text}"
                };

                postData(Underwear.registryURL, data);

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => LoginPage(),
                //     ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
