import 'package:electrical_comsuption/API.dart';
import 'package:electrical_comsuption/device_area.dart';
import 'package:electrical_comsuption/principal.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/user_area.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Containers extends StatefulWidget {
  const Containers({Key? key}) : super(key: key);

  @override
  State<Containers> createState() => _ContainersState();
}

class _ContainersState extends State<Containers> {
  // @override
  // void initState() {
  //   super.initState();

  //   getData(Underwear.listDevices).then((value) {
  //     if (value['status'] == 'success') {
  //       AppSnackBar().showSnack(context, "Erro ao pegar os dados", 2);
  //     } else {
  //       AppSnackBar().showSnack(context, "Erro ao pegar os dados", 2);
  //     }
  //   }).catchError((e) {
  //     AppSnackBar()
  //         .showSnack(context, "Erro inesperado, Erro ao pegar os dados", 2);
  //   });
  // }

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
            Navigator.pop(context);
          }),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.lightbulb_outline),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserArea(),
                ),
              );
            },
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            for (var i = 0; i < 5; i++) ...[
              Row(
                children: [
                  InkWell(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text('Casa ${i + 1}'),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Principal()),
                      );
                    },
                  )
                ],
              ),
              SizedBox(height: 20)
            ]
          ],
        ),
      ),
    );
  }
}
