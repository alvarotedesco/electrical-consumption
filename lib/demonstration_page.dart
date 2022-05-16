import 'package:brasil_fields/brasil_fields.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'themes/luvas.dart';
import 'login_page.dart';

class Demonstration extends StatefulWidget {
  @override
  State<Demonstration> createState() => _Demonstration();
}

class _Demonstration extends State<Demonstration> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Meias.imges), fit: BoxFit.cover),
        ),
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
                      ));
                })),
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: Luvas.consWatts,
                    labelStyle: AppTextStyles.defaultStyleB,
                  ),
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: Luvas.consHours,
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}