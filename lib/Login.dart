// ignore: file_names
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'demonstration.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'luvas.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/imges.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: Luvas.email,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(80),
                    border: const Border.fromBorderSide(
                      BorderSide(color: AppColors.secondary, width: 2),
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: Luvas.password,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 20),
                  )),
              AppButtonWidget(
                texto: Luvas.btSignIn,
                onPressed: () {},
              ),
              const SizedBox(height: 80),
              const SizedBox(
                height: 20,
                child: Text(
                  'Nao tem uma conta?',
                  style: TextStyle(color: Colors.white),
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
