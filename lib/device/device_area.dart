import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/constants.dart';
import 'package:electrical_comsuption/api.dart';
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
    if (powerDeviceController.text.trim().isEmpty &&
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Voltar'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          tooltip: 'Voltar',
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 130, left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            InputDecorationWidget(
              textInputType: TextInputType.name,
              controller: nameDeviceController,
              style: AppTextStyles.styleListB,
              label: Luvas.nameDevice,
            ),
            SizedBox(height: 10),
            InputDecorationWidget(
              controller: powerDeviceController,
              textInputType: TextInputType.name,
              style: AppTextStyles.styleListB,
              label: Luvas.powerDevice,
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    constraints: BoxConstraints.tight(
                      Size(
                        110,
                        75,
                      ),
                    ),
                    child: ListTile(
                      title: Image.asset(
                        Meias.flags[i],
                        alignment: Alignment.centerLeft,
                      ),
                      leading: Radio(
                        activeColor: AppColors.secondary,
                        groupValue: feeFlag,
                        value: i,
                        onChanged: (value) {
                          setState(() => feeFlag = int.parse(value.toString()));
                        },
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
    );
  }
}
