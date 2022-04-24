import 'package:electrical_comsuption/login_page.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'themes/luvas.dart';

class SignUpPage extends StatelessWidget {
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
                image: AssetImage(Meias.imges), fit: BoxFit.cover)),
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: Luvas.username,
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
                          width: 3, color: Color.fromARGB(255, 50, 15, 110)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 50, 15, 110)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ))),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: Luvas.cpf,
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
                          width: 3, color: Color.fromARGB(255, 50, 15, 110)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 50, 15, 110)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ))),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
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
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 50, 15, 110)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 50, 15, 110)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ))),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: Luvas.password,
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
                          width: 3, color: Color.fromARGB(255, 50, 15, 110)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 50, 15, 110)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ))),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            AppButtonWidget(
                texto: Luvas.btSigningUp,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
