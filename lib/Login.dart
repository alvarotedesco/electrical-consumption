import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'Demonstration.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  static const String email = 'E-mail';
  static const String password = 'Senha';
  static const String btSignIn = 'Login';
  static const String btSignUp = 'Cadastre-se';
  static const String btDemonstration = 'Demonstração';
  static const String noAccount = 'Não tem uma conta?';

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
                      labelText: email,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 50, 15, 110)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 50, 15, 110)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ))),
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: password,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 50, 15, 110)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 50, 15, 110)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ))),
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
                            btSignIn,
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
                        //     builder: (context) => SignUpPage(),
                        //   ),
                        // );
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
  }
}
