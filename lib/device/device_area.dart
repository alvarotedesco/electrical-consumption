import 'package:electrical_comsuption/device/device_controller.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/constants.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/floating_button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/device.dart';
import '../widgets/snackbar_widget.dart';

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
        }

        AppSnackBar()
            .showSnack(context, "Não foi possivel cadastrar seu Dispositivo!");
        return;
      });
    } else {
      controller.saveDevice(device).then((value) {
        if (value['status'] == 'success') {
          AppSnackBar().showSnack(context, "Dispositivo alterado com sucesso!");

          Navigator.of(context).pop();
        }

        AppSnackBar()
            .showSnack(context, "Não foi possivel alterar o dispositivo!");
        return;
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
        appBar: CustomAppBar(
          label:
              widget.device != null ? 'Editar Dispositivo' : 'Novo Dispositivo',
        ),
        floatingActionButton: FloatingCustomButtonWidget(
          cancel: true,
          selected: false,
          onConfirmButton: _save,
          onCancelButton: () => Navigator.of(context).pop(),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDecorationWidget(
                  textInputType: TextInputType.name,
                  controller: nameDeviceController,
                  style: AppTextStyles.h1WhiteBold,
                  label: Luvas.nameDevice,
                ),
                InputDecorationWidget(
                  controller: powerDeviceController,
                  textInputType: TextInputType.number,
                  style: AppTextStyles.h1WhiteBold,
                  label: Luvas.powerDevice,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
