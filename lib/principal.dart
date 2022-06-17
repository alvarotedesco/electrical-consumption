import 'package:electrical_comsuption/API.dart';
import 'package:electrical_comsuption/device_area.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/user_area.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final List<TextEditingController> hoursControllers = [];
  final List<TextEditingController> daysControllers = [];
  final List<TextEditingController> qtdControllers = [];
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
            onPressed: () async {
              if (await canLaunch(Underwear.dicasURL)) {
                await launch(Underwear.dicasURL);
              } else {
                AppSnackBar().showSnack(
                    context, "Não foi possivel acessar as Dicas!", 3);
              }
            },
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
                          )).then((v) {
                        getData(Underwear.listDevices).then((resp) {
                          if (resp['status'] == 'success') {
                            setState(() {
                              dropDevices = resp['data']["content"];
                            });
                          } else {
                            AppSnackBar().showSnack(
                                context, "Erro ao pegar os dados", 2);
                          }
                        }).catchError((e) {
                          AppSnackBar().showSnack(context,
                              "Erro inesperado, Erro ao pegar os dados", 2);
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
                            )).then((v) {
                          getData(Underwear.listDevices).then((resp) {
                            if (resp['status'] == 'success') {
                              setState(() {
                                dropDevices = resp['data']["content"];
                              });
                            } else {
                              AppSnackBar().showSnack(
                                  context, "Erro ao pegar os dados", 2);
                            }
                          }).catchError((e) {
                            AppSnackBar().showSnack(context,
                                "Erro inesperado, Erro ao pegar os dados", 2);
                          });
                        });
                      }),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 21),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 5,
                  isExpanded: true,
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
                  onChanged: ((value) {
                    for (var item in dropDevices) {
                      if (item["id"].toString() == value.toString()) {
                        print({'Item selecionado => ': item});
                        setState(() {
                          devices.add(item);
                          hoursControllers.add(TextEditingController());
                          daysControllers.add(TextEditingController());
                          qtdControllers.add(TextEditingController());
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
                                      SharedPreferences.getInstance()
                                          .then((inst) {
                                        inst.setInt(
                                            'idEdit',
                                            int.tryParse(devices[index]['id']
                                                .toString()));
                                        inst.setString('nameEdit',
                                            devices[index]['name'].toString());
                                        inst.setString('powerEdit',
                                            devices[index]['power'].toString());
                                        inst.setInt(
                                            'feeFlagEdit',
                                            int.tryParse(devices[index]
                                                    ['feeFlag']
                                                .toString()));
                                      }).then((val) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DeviceArea(),
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
                                              AppSnackBar().showSnack(context,
                                                  "Erro ao pegar os dados", 2);
                                            }
                                          }).catchError((e) {
                                            AppSnackBar().showSnack(
                                                context,
                                                "Erro inesperado, Erro ao pegar os dados",
                                                2);
                                          });
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
                                    textAlign: TextAlign.center,
                                    controller: hoursControllers[index],
                                    style: AppTextStyles.styleListB,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    keyboardType: TextInputType.number,
                                    onChanged: (tex) async {
                                      if (tex != "" && int.parse(tex) >= 24) {
                                        hoursControllers[index].text =
                                            (24).toString();
                                      }

                                      getTotal();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: daysControllers[index],
                                    style: AppTextStyles.styleListB,
                                    keyboardType: TextInputType.number,
                                    onChanged: (tex) async {
                                      if (tex != "" && int.parse(tex) >= 99) {
                                        daysControllers[index].text =
                                            (99).toString();
                                      }

                                      getTotal();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: qtdControllers[index],
                                    style: AppTextStyles.styleListB,
                                    keyboardType: TextInputType.number,
                                    onChanged: (tex) async {
                                      if (tex != "" && int.parse(tex) >= 999) {
                                        qtdControllers[index].text =
                                            (999).toString();
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
                                child: Text(totalKw,
                                    style: AppTextStyles.defaultStyleB),
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
                                child: Text(totalReais,
                                    style: AppTextStyles.defaultStyleB),
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
