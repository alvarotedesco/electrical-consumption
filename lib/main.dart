import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'UNORP', home: Bixo());
  }
}

class Bixo extends StatefulWidget {
  const Bixo({Key? key}) : super(key: key);

  @override
  State<Bixo> createState() => _BixoState();
}

class _BixoState extends State<Bixo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: BackButton(color: Colors.white),
          onPressed: () {},
          ),
          title: const Text("Titulo")),
      body: Table(
          border: TableBorder.all(
            borderRadius: BorderRadius.circular(50)),
          children: const [TableRow(
              children: <Widget> [
                CriaCampo(),
                CriaCampo(),
                CriaCampo()]
              )]
      )
    );
  }
}

class CriaCampo extends StatefulWidget {
  const CriaCampo({Key? key}) : super(key: key);

  @override
  State<CriaCampo> createState() => _CriaCampoState();
}

class _CriaCampoState extends State<CriaCampo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(left: 5),
      child: const TextField(
          textAlign: TextAlign.center,
          autofocus: true,
          style: TextStyle(
              color: Colors.white,
              fontSize: 25)
      ),
    );
    }
}
