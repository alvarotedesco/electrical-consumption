import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';
import 'SignUp.dart';
import 'Demonstration.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String email = 'E-mail';
  static const String password = 'Senha';
  static const String btSignIn = 'Login';
  static const String btSignUp = 'Cadastre-se';
  static const String btDemonstration = 'Demonstração';
  static const String noAccount = 'Não tem uma conta?';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String url = "";
  late String data;
  String Querytext = 'Não tem uma cnta?';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/imges.png'), fit: BoxFit.cover)),
      padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                url =
                    'https://google.com.br';
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "E-mail",
                focusColor: Colors.amber,
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
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color.fromARGB(255, 50, 15, 110),
                    Colors.deepPurple,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: SizedBox(
                height: 60,
                child: TextButton(
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                          child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => LogonPage(),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
                height: 20,
                child: Text(
                  Querytext,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Container(
                margin: const EdgeInsets.only(top: 5),
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color.fromARGB(255, 50, 15, 110),
                      Colors.deepPurple,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: SizedBox(
                  height: 60,
                  child: SizedBox(
                    child: TextButton(
                        child: Row(children: const <Widget>[
                          Expanded(
                              child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )),
<<<<<<< HEAD
                        ],
                      ),
                      onPressed: () {
                        login();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const SizedBox(
                    height: 20,
                    child: Text(
                      'Nao tem uma conta?',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 1],
                        colors: [
                          Color.fromARGB(255, 50, 15, 110),
                          Colors.deepPurple,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: SizedBox(
                      height: 60,
                      child: SizedBox(
                        child: TextButton(
                            child: Row(children: const <Widget>[
                              Expanded(
                                  child: Text(
                                btSignUp,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              )),
                            ]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            }),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 1],
                        colors: [
                          Color.fromARGB(255, 50, 15, 110),
                          Colors.deepPurple,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: SizedBox(
                      height: 60,
                      child: SizedBox(
                        child: TextButton(
                            child: Row(children: const <Widget>[
                              Expanded(
                                  child: Text(
                                btDemonstration,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              )),
                            ]),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Demonstration()));
                            }),
                      ),
                    )),
              ],
            ),
          ),
        ));
=======
                        ]),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        }),
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color.fromARGB(255, 50, 15, 110),
                      Colors.deepPurple,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: SizedBox(
                  height: 60,
                  child: SizedBox(
                    child: TextButton(
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Text(
                            "Demonstracao",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ]),
                        onPressed: () async {
                          data = await getData(url);

                          setState(() {
                            Querytext = data;
                          });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SignupPage(),
                          //   ),
                          // );
                        }),
                  ),
                )),
            SizedBox(
                height: 20,
                child: Text(
                  Querytext,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
>>>>>>> 1abdc7fb88734433f7eedda25e74ddf5673c28e5
  }
}

class _WindowDemons {}

Future<http.Response> login() async {
  var response = await http.get(
    Uri.parse('https://www.google.com.br/'),
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
  );

  print(json.decode(response.body));

  print(response.statusCode);

  return response;
}
