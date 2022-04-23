import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Login.dart';

class Demonstration extends StatefulWidget {
  @override
  State<Demonstration> createState() => _WindowDemons();
}

class _WindowDemons extends State<Demonstration> {
  static const comsWatts = 'Consumo em Watts:';
  static const comsHours = 'Horas de uso por dia:';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/imges.png'), fit: BoxFit.cover)),
            child: Scaffold(
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
                          ),
                        );
                      }),
                    )),
                backgroundColor: Colors.transparent,
                body: Container(
                    padding:
                        const EdgeInsets.only(top: 60, left: 40, right: 40),
                    child: ListView(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: comsWatts,
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: Colors.red),
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
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: comsHours,
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: Colors.red),
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
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 20),
                        )
                      ],
                    )))));
  }
}
