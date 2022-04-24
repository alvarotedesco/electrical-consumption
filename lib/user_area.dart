import 'package:electrical_comsuption/login.dart';
import 'package:flutter/material.dart';
import 'luvas.dart';

class UserArea extends StatefulWidget {
  const UserArea({Key? key}) : super(key: key);

  @override
  State<UserArea> createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  String userName = "user";
  String userMail = "Email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voltar'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(children: [
        Container(
            alignment: Alignment.center,
            child: Text(
              "ola",
              textAlign: TextAlign.end,
            ))
      ]),
    );
  }
}
