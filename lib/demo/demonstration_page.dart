import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/constants.dart';
import '../auth/login_page.dart';

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
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Voltar'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
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
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: AppTextStyles.defaultStyleB,
                    labelText: Luvas.consWatts,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    labelText: Luvas.consHours,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
