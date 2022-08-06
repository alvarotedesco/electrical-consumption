import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/principal/principal_state.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/floating_button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/snackbar_widget.dart';
import 'principal_controller.dart';

class Principal extends StatefulWidget {
  final int containerId;

  const Principal({
    required this.containerId,
    super.key,
  });

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final PrincipalController controller = PrincipalController();

  final productController = TextEditingController();
  final nomeEqController = TextEditingController();
  final pwrEqController = TextEditingController();
  final control = TextEditingController();

  String totalReais = "0.0";
  String totalKw = "0.0";
  String panelName = '';

  List<String> texts = [
    'Nome',
    'Pot. (w)',
    'Hrs',
    'Dias',
    'Qtd',
  ];

  DeviceModel? _selectedDevice;

  void _getTotal() {
    double tots = 0.0;
    for (var i = 0; i < controller.containerDevices.length; i++) {
      int hour = int.parse(controller.hoursControllers[i].text);
      int day = int.parse(controller.daysControllers[i].text);
      int qtd = int.parse(controller.qtdControllers[i].text);
      double pwr = controller.containerDevices[i].power;

      tots += hour * day * qtd * pwr / 1000;
    }

    double toR = tots * 1.04;
    setState(() {
      totalReais = toR.toStringAsFixed(2);
      totalKw = tots.toStringAsFixed(2);
    });
  }

  Future _clickOnDevice(DeviceModel deviceSelected) {
    // Navigator.pushNamed(
    //   context,
    //   '/editar-dispositivo',
    //   arguments: controller.containerDevices[index],
    // ).then((value) {
    //   controller.getContainerDevice(widget.containerId).catchError((e) {
    //     AppSnackBar().showSnack(
    //       context,
    //       "Erro inesperado, Erro ao pegar os dados",
    //     );
    //   });
    // });
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                deviceSelected.name,
                style: AppTextStyles.h3BlackBold,
              ),
              actions: [
                InputDecorationWidget(
                  textInputType: TextInputType.number,
                  controller: TextEditingController(
                    text: '${deviceSelected.power}',
                  ),
                  label: 'Potência',
                ),
              ],
            ));
  }

  void _onDelete() {
    controller.removeContainerDevice(_selectedDevice!.id!);
  }

  Widget? _errorWidget() {
    return controller.state == PrincipalState.loading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.secondary,
            ),
          )
        : null;
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
    controller.containerId = widget.containerId;

    controller.getContainerDevice(widget.containerId).catchError((e) {
      AppSnackBar().showSnack(
        context,
        "Erro inesperado, Erro ao pegar os dados",
      );
    });
    controller.getDevices().then((value) => _getTotal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      floatingActionButton: FloatingCustomButtonWidget(
        selected: _selectedDevice != null,
        onDeleteButton: _onDelete,
        canCreate: false,
      ),
      body: controller.state != PrincipalState.success
          ? _errorWidget()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        panelName,
                        style: AppTextStyles.h1WhiteBold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: AppColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        underline: SizedBox(height: 0),
                        iconSize: 25,
                        elevation: 5,
                        hint: Text(
                          'Selecione um Dispositivo',
                          style: AppTextStyles.h1WhiteBold,
                        ),
                        dropdownColor: AppColors.primary,
                        style: AppTextStyles.h1WhiteBold,
                        items: controller.dropDevices
                            .map<DropdownMenuItem<DeviceModel>>((value) {
                          return DropdownMenuItem<DeviceModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          print({'Item selecionado => ': value});
                          setState(() {
                            controller.addDevice(device: value as DeviceModel);
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
                              children: [
                                for (var index = 0; index < 5; index++) ...[
                                  Expanded(
                                    flex: index == 0
                                        ? 4
                                        : index == 1
                                            ? 2
                                            : 1,
                                    child: Center(
                                      child: Text(
                                        texts[index],
                                        style: AppTextStyles.h3WhiteBold,
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height -
                                kBottomNavigationBarHeight -
                                kToolbarHeight -
                                183,
                            child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: controller.containerDevices.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () => _clickOnDevice(
                                      controller.containerDevices[index]),
                                  onLongPress: () {
                                    setState(() {
                                      if (_selectedDevice == null) {
                                        _selectedDevice =
                                            controller.containerDevices[index];
                                      } else {
                                        _selectedDevice = null;
                                      }
                                    });
                                  },
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: InkWell(
                                          child: Text(
                                            controller
                                                .containerDevices[index].name,
                                            style: AppTextStyles.h3WhiteBold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            controller
                                                .containerDevices[index].power
                                                .toString(),
                                            style: AppTextStyles.h3WhiteBold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: controller
                                              .hoursControllers[index],
                                          keyboardType: TextInputType.number,
                                          style: AppTextStyles.h3WhiteBold,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2),
                                          ],
                                          onChanged: (tex) {
                                            if (tex != "" &&
                                                int.parse(tex) >= 24) {
                                              controller.hoursControllers[index]
                                                  .text = '24';
                                            }

                                            _getTotal();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller:
                                              controller.daysControllers[index],
                                          keyboardType: TextInputType.number,
                                          style: AppTextStyles.h3WhiteBold,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2),
                                          ],
                                          onChanged: (tex) {
                                            if (tex != "") {
                                              if (int.parse(tex) >= 99) {
                                                controller
                                                    .daysControllers[index]
                                                    .text = '99';
                                              }
                                              _getTotal();
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller:
                                              controller.qtdControllers[index],
                                          style: AppTextStyles.h3WhiteBold,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(3),
                                          ],
                                          onChanged: (tex) {
                                            if (tex != "") {
                                              if (int.parse(tex) >= 999) {
                                                controller.qtdControllers[index]
                                                    .text = '999';
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Consumo: ",
                                          style: AppTextStyles.h1WhiteBold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Text(
                                          '$totalKw kWh',
                                          style: AppTextStyles.h1WhiteBold,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Gasto: ",
                                          style: AppTextStyles.h1WhiteBold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Text(
                                          'R\$ $totalReais',
                                          style: AppTextStyles.h1WhiteBold,
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
            ),
    );
  }
}
