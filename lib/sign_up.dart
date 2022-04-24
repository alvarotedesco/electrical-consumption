import 'package:brasil_fields/brasil_fields.dart';
import 'package:electrical_comsuption/login.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'luvas.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordVisible = false;

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
                image: AssetImage('assets/imges.png'), fit: BoxFit.cover)),
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            InputDecorationWidget(
                textInputType: TextInputType.text, label: Luvas.username),
            const SizedBox(height: 10),
            InputDecorationWidget(inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ], textInputType: TextInputType.number, label: Luvas.cpf),
            const SizedBox(height: 10),
            InputDecorationWidget(
                textInputType: TextInputType.emailAddress, label: Luvas.email),
            const SizedBox(height: 10),
            InputDecorationWidget(
                isPassword: true,
                passwordVisible: passwordVisible,
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
                textInputType: TextInputType.text,
                label: Luvas.password),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.3,
                      1
                    ],
                    colors: [
                      Color.fromARGB(255, 50, 15, 110),
                      Colors.deepPurple,
                    ]),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                    child: Row(
                      children: const <Widget>[
                        Expanded(
                          child: Text(
                            Luvas.btSigningUp,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
