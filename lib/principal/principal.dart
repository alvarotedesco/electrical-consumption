import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/principal/principal_state.dart';
import 'package:electrical_comsuption/session_controller.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/box_widget.dart';
import 'package:electrical_comsuption/widgets/floating_button_widget.dart';
import 'package:flutter/material.dart';

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
  final SessionController session = SessionController();

  final productController = TextEditingController();
  final nomeEqController = TextEditingController();
  final pwrEqController = TextEditingController();
  final control = TextEditingController();

  DeviceModel? _selectedDevice;

  String totalReais = "0.0";
  String totalKw = "0.0";
  String panelName = '';

  int timeControl = 0;
  int? _actualIndexDevice;

  List<String> texts = [
    'Nome',
    'Pot. (w)',
    'Hrs',
    'Dias',
    'Qtd',
  ];

  void _getTotal() {
    double tots = 0.0;
    for (var i = 0; i < controller.containerDevices.length; i++) {
      double hour = double.parse(controller.hoursControllers[i].text);
      int day = int.parse(controller.daysControllers[i].text);
      int qtd = int.parse(controller.qtdControllers[i].text);
      double pwr = controller.containerDevices[i].power;

      tots += hour * day * qtd * pwr / 1000;
    }

    double toR = (tots * 1.04) + (tots * session.container!.flag!.cost);
    totalReais = toR.toStringAsFixed(2);
    totalKw = tots.toStringAsFixed(2);
  }

  void _onDelete() {
    controller.containerDevices.removeAt(_actualIndexDevice!);
    controller.daysControllers.removeAt(_actualIndexDevice!);
    controller.hoursControllers.removeAt(_actualIndexDevice!);
    controller.qtdControllers.removeAt(_actualIndexDevice!);
    controller.makeDataToSave();
    _actualIndexDevice = null;
    _selectedDevice = null;
  }

  void _addDevice(DeviceModel device) {
    setState(() => controller.addDevice(device: device));
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
      setState(() => _getTotal());
    });
    controller.containerId = widget.containerId;

    controller.getContainerDevice(widget.containerId).then((_) {
      controller.getDevices().then((value) => setState(() => _getTotal()));
    }).catchError((e) {
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
      floatingActionButton: FloatingCustomButtonWidget(
        selected: _selectedDevice != null,
        onDeleteButton: _onDelete,
        onEditButton: () async {
          timeControl = await BoxDialog(context: context)
              .clickOnDevice(controller, _actualIndexDevice!);

          if (timeControl == 1) {
            controller
                .hoursControllers[_actualIndexDevice!].text = (double.parse(
                        controller.hoursControllers[_actualIndexDevice!].text) /
                    60)
                .toStringAsFixed(2);
          }
        },
        canCreate: false,
      ),
      body: controller.state != PrincipalState.success
          ? _errorWidget()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                        onChanged: (val) {
                          _addDevice(val as DeviceModel);
                          _getTotal();
                          controller.makeDataToSave();
                        }),
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
                                selected: _selectedDevice ==
                                    controller.containerDevices[index],
                                selectedTileColor: _selectedDevice ==
                                        controller.containerDevices[index]
                                    ? AppColors.secondary
                                    : null,
                                onTap: () async {
                                  timeControl = await BoxDialog(
                                    context: context,
                                  ).clickOnDevice(controller, index);

                                  if (timeControl == 1) {
                                    controller.hoursControllers[index].text =
                                        (double.parse(controller
                                                    .hoursControllers[index]
                                                    .text) /
                                                60)
                                            .toStringAsFixed(2);
                                  }
                                },
                                onLongPress: () {
                                  setState(() {
                                    if (_selectedDevice == null) {
                                      _selectedDevice =
                                          controller.containerDevices[index];
                                      _actualIndexDevice = index;
                                    } else {
                                      _selectedDevice = null;
                                      _actualIndexDevice = null;
                                    }
                                  });
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        controller.containerDevices[index].name,
                                        style: AppTextStyles.h3WhiteBold,
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
                                      child: Text(
                                        controller.hoursControllers[index].text,
                                        style: AppTextStyles.h3WhiteBold,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.daysControllers[index].text,
                                        style: AppTextStyles.h3WhiteBold,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.qtdControllers[index].text,
                                        style: AppTextStyles.h3WhiteBold,
                                        textAlign: TextAlign.center,
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
    );
  }
}
