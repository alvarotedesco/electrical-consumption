import 'package:electrical_comsuption/API.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/list_view.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:flutter/services.dart';

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
  String totalKw = "0";
  int onOpen = 375;
  bool addEq = false;
  List devices = [];
  List dropDevices = [];

  @override
  void initState() {
    super.initState();

    getTotal().then((value) {
      setState(() {
        totalKw = value.toString();
      });
    });

    getData(Underwear.listDevices).then((value) {
      setState(() {
        dropDevices = value["content"];
      });
    }).catchError((e) {
      AppSnackBar().showSnack(context, "Error ao pegar os dados $e", 2);
    });
  }

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
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      icon: const Icon(Icons.add_circle),
                      color: AppColors.white,
                      onPressed: () {
                        setState(() {
                          addEq = !addEq;
                        });

                        if (addEq) {
                          setState(() {
                            onOpen = 480;
                          });
                        } else {
                          setState(() {
                            onOpen = 375;
                          });
                        }
                      },
                    ),
                    InkWell(
                      child: const Text(
                        "Cadastrar novo Equipamento",
                        style: AppTextStyles.defaultStyleB,
                      ),
                      onTap: () {
                        setState(() {
                          addEq = !addEq;
                        });

                        if (addEq) {
                          setState(() {
                            onOpen = 480;
                          });
                        } else {
                          setState(() {
                            onOpen = 375;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                          style: AppTextStyles.styleListB,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: InputDecorationWidget(
                          controller: pwrEqController,
                          label: "Potencia (W)",
                          textInputType: TextInputType.number,
                          style: AppTextStyles.styleListB,
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
                      if (pwrEqController.text.isNotEmpty &&
                          nomeEqController.text.isNotEmpty) {
                        var data = {
                          "name": nomeEqController.text,
                          "description": "",
                          "power": int.tryParse(pwrEqController.text)
                        };
                        postData(Underwear.saveDevice, data).then((value) {
                          setState(() {
                            addEq = !addEq;
                            pwrEqController.text = "";
                            nomeEqController.text = "";
                          });

                          if (addEq) {
                            setState(() {
                              onOpen = 480;
                            });
                          } else {
                            setState(() {
                              onOpen = 375;
                            });
                          }
                        });
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 21),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    isExpanded: true,
                    hint: const Text(
                      'Selecione um Equipamento',
                      style: AppTextStyles.defaultStyleB,
                    ),
                    items: dropDevices.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value["id"].toString(),
                        child: Text(value["name"]),
                      );
                    }).toList(),
                    onChanged: ((value) {
                      for (var item in dropDevices) {
                        if (item["id"].toString() == value.toString()) {
                          print(item);
                          setState(() {
                            devices.add(item);
                          });
                        }
                      }
                    }),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "meu painel",
                    style: AppTextStyles.defaultStyleB,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - onOpen,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: ListWidget(
                    devices: devices,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Total (Kw/h)",
                            style: AppTextStyles.defaultStyleB,
                          ),
                          Text(totalKw, style: AppTextStyles.defaultStyleB),
                        ],
                      ),
                    ],
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
