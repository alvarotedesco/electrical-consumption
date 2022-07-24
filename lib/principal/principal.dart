import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/device/device_area.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/constants.dart';
import 'package:electrical_comsuption/user/user_area.dart';
import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final List<TextEditingController> hoursControllers = [];
  final List<TextEditingController> daysControllers = [];
  final List<TextEditingController> qtdControllers = [];
  final productController = TextEditingController();
  final nomeEqController = TextEditingController();
  final pwrEqController = TextEditingController();
  final control = TextEditingController();
  String totalReais = "0.0";
  String totalKw = "0.0";
  List devices = [];
  List dropDevices = [
    {'id': '1', 'name': "ventilador", "power": 600.0, "feeFlag": 3}
  ];

  void getTotal() {
    var ind = devices.length;
    var tots = 0.0;

    for (var i = 0; i < ind; i++) {
      var hour = int.parse(
          hoursControllers[i].text != "" ? hoursControllers[i].text : '0');
      var day = int.parse(
          daysControllers[i].text != "" ? daysControllers[i].text : '0');
      var qtd = int.parse(
          qtdControllers[i].text != "" ? qtdControllers[i].text : '0');
      var pwr = devices[i]['power'];

      tots += hour * day * qtd * pwr / 1000;
    }

    var toR = tots * 0.97;
    setState(() {
      totalReais = toR.toStringAsFixed(2);
      totalKw = tots.toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();

    getData(Underwear.listDevices).then((value) {
      if (value['status'] == 'success') {
        setState(() {
          dropDevices = value['data']["content"];
        });
      } else {
        AppSnackBar().showSnack(context, "Erro ao pegar os dados", 2);
      }
    }).catchError((e) {
      AppSnackBar()
          .showSnack(context, "Erro inesperado, Erro ao pegar os dados", 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Voltar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () async {
              if (await canLaunch(Underwear.dicasURL)) {
                await launch(Underwear.dicasURL);
              } else {
                AppSnackBar().showSnack(
                    context, "Não foi possivel acessar as Dicas!", 3);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserArea(),
                ),
              );
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeviceArea(),
                        ),
                      ).then((v) {
                        getData(Underwear.listDevices).then((resp) {
                          if (resp['status'] == 'success') {
                            setState(() {
                              dropDevices = resp['data']["content"];
                            });
                          } else {
                            AppSnackBar().showSnack(
                              context,
                              "Erro ao pegar os dados",
                              2,
                            );
                          }
                        }).catchError((e) {
                          AppSnackBar().showSnack(
                            context,
                            "Erro inesperado, Erro ao pegar os dados",
                            2,
                          );
                        });
                      });
                    },
                  ),
                  InkWell(
                    child: const Text(
                      "Cadastrar novo Dispositivo",
                      style: AppTextStyles.defaultStyleB,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeviceArea(),
                        ),
                      ).then((v) {
                        getData(Underwear.listDevices).then((resp) {
                          if (resp['status'] == 'success') {
                            setState(() {
                              dropDevices = resp['data']["content"];
                            });
                          } else {
                            AppSnackBar().showSnack(
                              context,
                              "Erro ao pegar os dados",
                              2,
                            );
                          }
                        }).catchError((e) {
                          AppSnackBar().showSnack(
                            context,
                            "Erro inesperado, Erro ao pegar os dados",
                            2,
                          );
                        });
                      });
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 21),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: true,
                  elevation: 5,
                  hint: const Text(
                    'Selecione um Dispositivo',
                    style: AppTextStyles.defaultStyleB,
                  ),
                  items: dropDevices.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value["id"].toString(),
                      child: Text(value["name"]),
                    );
                  }).toList(),
                  onChanged: (value) {
                    for (var item in dropDevices) {
                      if (item["id"].toString() == value.toString()) {
                        print({'Item selecionado => ': item});
                        setState(() {
                          hoursControllers.add(TextEditingController());
                          daysControllers.add(TextEditingController());
                          qtdControllers.add(TextEditingController());
                          devices.add(item);
                        });
                      }
                    }
                  },
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
                padding: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.black60,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 180,
                          alignment: Alignment.center,
                          child: const Text(
                            'Nome',
                            style: AppTextStyles.styleListB,
                          ),
                        ),
                        const Text(
                          'Pot. (w)',
                          style: AppTextStyles.styleListB,
                        ),
                        const Text(
                          'Hrs',
                          style: AppTextStyles.styleListB,
                        ),
                        const Text(
                          'Dias',
                          style: AppTextStyles.styleListB,
                        ),
                        const Text(
                          'Qtd',
                          style: AppTextStyles.styleListB,
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: InkWell(
                                    child: Text(
                                      devices[index]["name"],
                                      style: AppTextStyles.styleListB,
                                    ),
                                    onTap: () {
                                      var device = DeviceModel(
                                        power: "${devices[index]['power']}",
                                        name: "${devices[index]['name']}",
                                        flag: int.parse(
                                            "${devices[index]['feeFlag']}"),
                                        id: int.parse(
                                            "${devices[index]['id']}"),
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DeviceArea(device: device),
                                        ),
                                      ).then((v) {
                                        getData(Underwear.listDevices)
                                            .then((resp) {
                                          if (resp['status'] == 'success') {
                                            setState(() {
                                              dropDevices =
                                                  resp['data']["content"];
                                            });
                                          } else {
                                            AppSnackBar().showSnack(
                                              context,
                                              "Erro ao pegar os dados",
                                              2,
                                            );
                                          }
                                        }).catchError((e) {
                                          AppSnackBar().showSnack(
                                            context,
                                            "Erro inesperado, Erro ao pegar os dados",
                                            2,
                                          );
                                        });
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      devices[index]["power"].toString(),
                                      style: AppTextStyles.styleListB,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                  child: TextField(
                                    controller: hoursControllers[index],
                                    keyboardType: TextInputType.number,
                                    style: AppTextStyles.styleListB,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    onChanged: (tex) async {
                                      if (tex != "" && int.parse(tex) >= 24) {
                                        hoursControllers[index].text = '24';
                                      }

                                      getTotal();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                  child: TextField(
                                    controller: daysControllers[index],
                                    keyboardType: TextInputType.number,
                                    style: AppTextStyles.styleListB,
                                    textAlign: TextAlign.center,
                                    onChanged: (tex) async {
                                      if (tex != "" && int.parse(tex) >= 99) {
                                        daysControllers[index].text = '99';
                                      }

                                      getTotal();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: qtdControllers[index],
                                    style: AppTextStyles.styleListB,
                                    textAlign: TextAlign.center,
                                    onChanged: (tex) async {
                                      if (tex != "" && int.parse(tex) >= 999) {
                                        qtdControllers[index].text = '999';
                                      }

                                      getTotal();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 200,
                                child: Text(
                                  "Total (Kw/h)",
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 100,
                                child: Text(
                                  totalKw,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 200,
                                child: Text(
                                  "Total (R\$)",
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 100,
                                child: Text(
                                  totalReais,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
