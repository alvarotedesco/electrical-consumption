import 'package:electrical_comsuption/device/device_area.dart';
import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Principal extends StatefulWidget {
  final int painelId;

  const Principal({
    Key? key,
    required this.painelId,
  }) : super(key: key);

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
  String panelName = '';
  List devices = [];
  List dropDevices = [
    {'id': '1', 'name': "ventilador", "power": 600.0, "feeFlag": 3}
  ];

  void _getTotal() {
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

    var toR = tots * 1.04;
    setState(() {
      totalReais = toR.toStringAsFixed(2);
      totalKw = tots.toStringAsFixed(2);
    });
  }

  void _clickOnDevice(index) {
    var device = DeviceModel(
      power: "${devices[index]['power']}",
      name: "${devices[index]['name']}",
      flag: int.parse("${devices[index]['feeFlag']}"),
      id: int.parse("${devices[index]['id']}"),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeviceArea(device: device),
      ),
    );
    // .then((v) {
    //   getData(Underwear.listDevices).then((resp) {
    //     if (resp['status'] == 'success') {
    //       setState(() {
    //         dropDevices = resp['data']["content"];
    //       });
    //     } else {
    //       AppSnackBar().showSnack(context, "Erro ao pegar os dados");
    //     }
    //   }).catchError((e) {
    //     AppSnackBar()
    //         .showSnack(context, "Erro inesperado, Erro ao pegar os dados");
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();

    panelName = 'Casa ${widget.painelId + 1}';

    // getData(Underwear.listDevices).then((value) {
    //   if (value['status'] == 'success') {
    //     setState(() {
    //       dropDevices = value['data']["content"];
    //     });
    //   } else {
    //     AppSnackBar().showSnack(context, "Erro ao pegar os dados");
    //   }
    // }).catchError((e) {
    //   AppSnackBar()
    //       .showSnack(context, "Erro inesperado, Erro ao pegar os dados");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                panelName,
                style: AppTextStyles.defaultStyleB,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                elevation: 5,
                hint: Text(
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
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.black60,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: Text(
                              'Nome',
                              style: AppTextStyles.styleListB,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Pot. (w)',
                              style: AppTextStyles.styleListB,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Hrs',
                              style: AppTextStyles.styleListB,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Dias',
                              style: AppTextStyles.styleListB,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Qtd',
                              style: AppTextStyles.styleListB,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: InkWell(
                                  onTap: () => _clickOnDevice(index),
                                  child: Text(
                                    devices[index]["name"],
                                    style: AppTextStyles.styleListB,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    devices[index]["power"].toString(),
                                    style: AppTextStyles.styleListB,
                                  ),
                                ),
                              ),
                              Expanded(
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

                                    _getTotal();
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: daysControllers[index],
                                  keyboardType: TextInputType.number,
                                  style: AppTextStyles.styleListB,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(2),
                                  ],
                                  onChanged: (tex) async {
                                    if (tex != "" && int.parse(tex) >= 99) {
                                      daysControllers[index].text = '99';
                                    }

                                    _getTotal();
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: qtdControllers[index],
                                  style: AppTextStyles.styleListB,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  onChanged: (tex) async {
                                    if (tex != "" && int.parse(tex) >= 999) {
                                      qtdControllers[index].text = '999';
                                    }

                                    _getTotal();
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
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Total (Kw/h)",
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  totalKw,
                                  style: AppTextStyles.defaultStyleB,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Total (R\$)",
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  totalReais,
                                  style: AppTextStyles.defaultStyleB,
                                  textAlign: TextAlign.right,
                                ),
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
    );
  }
}
