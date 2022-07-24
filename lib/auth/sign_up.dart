import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/constants.dart';
import 'package:electrical_comsuption/models/user.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:electrical_comsuption/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      AppSnackBar().showSnack(context, "Preencha todos os campos!", 2);
      return;
    }

    if (cpf.length < 11) {
      AppSnackBar().showSnack(context, "Preencha o CPF corretamente", 2);
      return;
    }

    var user = UserModel(
      username: email,
      password: pass,
      name: name,
      cpf: cpf,
    );

    postData(Underwear.registryURL, user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text('Voltar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        child: ListView(
          children: [
            SizedBox(height: 20),
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
            AppButtonWidget(
              texto: Luvas.btSigningUp,
              onPressed: _registry,
            ),
          ],
        ),
      ),
    );
  }
}
