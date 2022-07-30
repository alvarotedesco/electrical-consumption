import 'package:electrical_comsuption/device/device_controller.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/constants.dart';
import 'package:flutter/services.dart';
import '../widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import '../models/device.dart';

class DeviceArea extends StatefulWidget {
  final DeviceModel? device;

  const DeviceArea({
    this.device,
    super.key,
  });

  @override
  State<DeviceArea> createState() => _DeviceAreaState();
}

class _DeviceAreaState extends State<DeviceArea> {
  DeviceController controller = DeviceController();

  final powerDeviceController = TextEditingController();
  final nameDeviceController = TextEditingController();

  int feeFlag = 0;
  int? id = 0;

  void _save() {
    if (powerDeviceController.text.trim().isEmpty ||
        nameDeviceController.text.trim().isEmpty) {
      AppSnackBar().showSnack(context, "Preencha todos os campos!");
      return;
    }

    DeviceModel device = DeviceModel(
      power: double.parse(powerDeviceController.text),
      name: nameDeviceController.text,
      id: id,
    );

    if (id == 0) {
      controller.createDevice(device).then((value) {
        if (value['status'] == 'success') {
          AppSnackBar()
              .showSnack(context, "Dispositivo cadastrado com sucesso!");

          Navigator.of(context).pop();
        } else {
          AppSnackBar().showSnack(
              context, "Não foi possivel cadastrar seu Dispositivo!");
        }
      }).catchError((e) {
        AppSnackBar().showSnack(context,
            "Erro inesperado, Não foi possivel salvar seu Dispositivo!");
      });
    } else {
      controller.saveDevice(device).then((value) {
        if (value['status'] == 'success') {
          AppSnackBar().showSnack(context, "Dispositivo alterado com sucesso!");

          Navigator.of(context).pop();
        } else {
          AppSnackBar()
              .showSnack(context, "Não foi possivel alterar o dispositivo!");
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    if (widget.device != null) {
      setState(() {
        powerDeviceController.text = widget.device!.power.toString();
        nameDeviceController.text = widget.device!.name;
        id = widget.device!.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: CustomAppBar(),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Card(
              color: AppColors.white60,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Luvas.registerDevice,
                      style: AppTextStyles.totalStyle,
                    ),
                    SizedBox(height: 20),
                    InputDecorationWidget(
                      textInputType: TextInputType.name,
                      controller: nameDeviceController,
                      style: AppTextStyles.totalStyle,
                      label: Luvas.nameDevice,
                    ),
                    SizedBox(height: 10),
                    InputDecorationWidget(
                      controller: powerDeviceController,
                      textInputType: TextInputType.number,
                      style: AppTextStyles.totalStyle,
                      label: Luvas.powerDevice,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      Luvas.selectFlag,
                      style: AppTextStyles.totalStyle,
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          // for (int i = 0; i < controller.listDevices.length; i++)
                          Card(
                            color: AppColors.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio(
                                  activeColor: AppColors.white,
                                  groupValue: feeFlag,
                                  value: i,
                                  onChanged: (value) {
                                    setState(() {
                                      feeFlag = int.parse('$value');
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      feeFlag = i;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    height: 40,
                                    child: Image.asset(
                                      Meias.flags[i],
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButtonWidget(
                          style: AppTextStyles.btnSave,
                          width: 80,
                          texto: "Salvar",
                          onPressed: _save,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
