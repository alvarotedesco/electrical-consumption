import 'package:electrical_comsuption/API.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/list_view.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final productController = TextEditingController();
  final nomeEqController = TextEditingController();
  final pwrEqController = TextEditingController();
  final control = TextEditingController();
  bool addEq = false;
  List devices = [
    {"name": "Chuveiro", "power": "1500"},
    {"name": "Microondas", "power": "10000"},
    {"name": "TV", "power": "90"},
    {"name": "Fonte Note", "power": "60"},
    {"name": "Pilha", "power": "2"},
    {"name": "Tesla", "power": "100000"}
  ];

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
            Navigator.pop(
              context,
            );
          }),
        ),
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Meias.imges),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      iconSize: 35,
                      icon: Icon(Icons.add_circle),
                      color: AppColors.white,
                      onPressed: () {
                        setState(() {
                          addEq = !addEq;
                        });
                      },
                    ),
                    InkWell(
                      child: Text(
                        "Adicionar novo Equipamento",
                        style: AppTextStyles.defaultStyleB,
                      ),
                      onTap: () {
                        setState(() {
                          addEq = !addEq;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: addEq,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: InputDecorationWidget(
                          controller: nomeEqController,
                          label: "Nome do dispositivo",
                          textInputType: TextInputType.name,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: InputDecorationWidget(
                          controller: pwrEqController,
                          label: "Potencia (W)",
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: addEq,
                  child: AppButtonWidget(
                    texto: "Salvar",
                    onPressed: () {
                      setState(() {
                        addEq = !addEq;
                        pwrEqController.text = "";
                        nomeEqController.text = "";
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "meu painel",
                    style: AppTextStyles.defaultStyleB,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 360,
                  child: ListWidget(
                    devices: devices,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> testeGet() {
  dynamic urll = "device/list?page=0";
  var teste = getData(urll);
  print(teste);
  return teste;
}
