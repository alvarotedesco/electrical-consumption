import 'package:electrical_comsuption/device/device_area.dart';
import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/snackbar_widget.dart';
import 'principal_controller.dart';

class Principal extends StatefulWidget {
  final int painelId;

  const Principal({
    required this.painelId,
    super.key,
  });

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final PrincipalController controller = PrincipalController();

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

  List<DeviceModel> devices = [];
  List<DeviceModel> dropDevices = [
    DeviceModel(power: 600.0, name: "ventilador", flag: 3, id: 1),
    DeviceModel(power: 9.0, name: "Lampada LED", flag: 2, id: 2),
    DeviceModel(power: 100.0, name: "Carregador Notebook", flag: 1, id: 3),
    DeviceModel(power: 200.0, name: "Outro Item", flag: 4, id: 4),
    DeviceModel(power: 1500.0, name: "Microondas", flag: 1, id: 5),
  ];

  void _getTotal() {
    double tots = 0.0;
    for (var i = 0; i < devices.length; i++) {
      int hour = int.parse(hoursControllers[i].text);
      int day = int.parse(daysControllers[i].text);
      int qtd = int.parse(qtdControllers[i].text);
      double pwr = devices[i].power;

      tots += hour * day * qtd * pwr / 1000;
    }

    double toR = tots * 1.04;
    setState(() {
      totalReais = toR.toStringAsFixed(2);
      totalKw = tots.toStringAsFixed(2);
    });
  }

  void _clickOnDevice(int index) {
    Navigator.pushNamed(
      context,
      '/editar-dispositivo',
      arguments: devices[index],
    ).then((value) {
      controller.getContainerDevice(widget.painelId).catchError((e) {
        AppSnackBar().showSnack(
          context,
          "Erro inesperado, Erro ao pegar os dados",
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    controller.getContainerDevice(widget.painelId).catchError((e) {
      AppSnackBar().showSnack(
        context,
        "Erro inesperado, Erro ao pegar os dados",
      );
    });
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
                items: dropDevices.map<DropdownMenuItem<DeviceModel>>((value) {
                  return DropdownMenuItem<DeviceModel>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (value) {
                  print({'Item selecionado => ': value});
                  setState(() {
                    hoursControllers.add(TextEditingController());
                    daysControllers.add(TextEditingController());
                    qtdControllers.add(TextEditingController());
                    devices.add(value as DeviceModel);
                  });
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
                                    devices[index].name,
                                    style: AppTextStyles.styleListB,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    devices[index].power.toString(),
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
                                    if (tex != "") {
                                      if (int.parse(tex) >= 99) {
                                        daysControllers[index].text = '99';
                                      }
                                      _getTotal();
                                    }
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
                                    if (tex != "") {
                                      if (int.parse(tex) >= 999) {
                                        qtdControllers[index].text = '999';
                                      }
                                      _getTotal();
                                    }
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
