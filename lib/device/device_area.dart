import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/constants.dart';
import 'package:electrical_comsuption/api.dart';
import 'package:flutter/services.dart';
import '../widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import '../models/device.dart';
import '../api.dart';

class DeviceArea extends StatefulWidget {
  final DeviceModel? device;

  const DeviceArea({
    Key? key,
    this.device,
  }) : super(key: key);

  @override
  State<DeviceArea> createState() => _DeviceAreaState();
}

class _DeviceAreaState extends State<DeviceArea> {
  final powerDeviceController = TextEditingController();
  final nameDeviceController = TextEditingController();
  int feeFlag = 0;
  int id = 0;

  void _save() {
    if (powerDeviceController.text.trim().isEmpty ||
        nameDeviceController.text.trim().isEmpty) {
      AppSnackBar().showSnack(context, "Preencha todos os campos!");
      return;
    }

    var device = DeviceModel(
      power: powerDeviceController.text,
      name: nameDeviceController.text,
      flag: feeFlag,
      id: id,
    );

    postDevice(Underwear.saveDevice, device).then((value) {
      if (id == 0) {
        if (value['status'] == 'success') {
          AppSnackBar()
              .showSnack(context, "Dispositivo cadastrado com sucesso!");

          Navigator.of(context).pop();
        } else {
          AppSnackBar().showSnack(
              context, "Não foi possivel cadastrar seu Dispositivo!");
        }
      } else {
        if (value['status'] == 'success') {
          AppSnackBar().showSnack(context, "Dispositivo alterado com sucesso!");

          Navigator.of(context).pop();
        } else {
          AppSnackBar()
              .showSnack(context, "Não foi possivel alterar o dispositivo!");
        }
      }
    }).catchError((e) {
      AppSnackBar().showSnack(
          context, "Erro inesperado, Não foi possivel salvar seu Dispositivo!");
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.device != null) {
      setState(() {
        powerDeviceController.text = widget.device!.power;
        nameDeviceController.text = widget.device!.name;
        feeFlag = widget.device!.flag;
        id = widget.device!.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Card(
            color: AppColors.white60,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: EdgeInsets.all(30),
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
                    textInputType: TextInputType.name,
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
                        Card(
                          color: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            constraints: BoxConstraints.tight(
                              Size(
                                110,
                                50,
                              ),
                            ),
                            child: ListTile(
                              title: Image.asset(
                                Meias.flags[i],
                                alignment: Alignment.centerLeft,
                              ),
                              leading: Radio(
                                activeColor: AppColors.white,
                                groupValue: feeFlag,
                                value: i,
                                onChanged: (value) {
                                  setState(() =>
                                      feeFlag = int.parse(value.toString()));
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AppButtonWidget(
                    texto: "Salvar",
                    onPressed: _save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
