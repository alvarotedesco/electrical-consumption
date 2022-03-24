import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: MyStateWidgets());
  }
}

class MyStateWidgets extends StatelessWidget {
  const MyStateWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Builder(builder: (BuildContext context) {
              return BackButton(
                color: Colors.white,
                onPressed: () {},
              );
            }),
            title: const Text('Voltar')));
  }
}
