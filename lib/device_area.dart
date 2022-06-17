import 'package:electrical_comsuption/API.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API.dart';
import 'widgets/snackbar_widget.dart';

class DeviceArea extends StatefulWidget {
  @override
  State<DeviceArea> createState() => _DeviceAreaState();
}

class _DeviceAreaState extends State<DeviceArea> {
  final nameDeviceController = TextEditingController();
  final powerDeviceController = TextEditingController();
  int id = 0;
  int feeFlag = 0;

  void clean() {
    SharedPreferences.getInstance().then((instance) {
      instance.remove('idEdit');
      instance.remove('nameEdit');
      instance.remove('powerEdit');
      instance.remove('feeFlagEdit');
    });
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((instance) {
      setState(() {
        id = instance.getInt('idEdit') ?? 0;
        nameDeviceController.text = instance.getString('nameEdit') ?? '';
        powerDeviceController.text = instance.getString('powerEdit') ?? '';
        feeFlag = instance.getInt('feeFlagEdit') ?? 0;
      });
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
            clean();
            Navigator.pop(context);
          }),
        ),
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
        child: ListView(
          children: <Widget>[
            InputDecorationWidget(
              controller: nameDeviceController,
              label: Luvas.nameDevice,
              textInputType: TextInputType.name,
              style: AppTextStyles.styleListB,
            ),
            const SizedBox(height: 10),
            InputDecorationWidget(
              controller: powerDeviceController,
              label: Luvas.powerDevice,
              textInputType: TextInputType.name,
              style: AppTextStyles.styleListB,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 4; i++)
                  Container(
                    constraints: BoxConstraints.tight(Size(110, 75)),
                    child: ListTile(
                      title: Image.asset(Meias.flags[i],
                          alignment: Alignment.centerLeft),
                      leading: Radio(
                        value: i,
                        groupValue: feeFlag,
                        activeColor: AppColors.secondary,
                        onChanged: (value) {
                          setState(() {
                            feeFlag = int.parse(value.toString());
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 4; i < 5; i++)
                  Container(
                    constraints: BoxConstraints.tight(Size(110, 75)),
                    child: ListTile(
                      title: Image.asset(Meias.flags[i],
                          alignment: Alignment.centerLeft),
                      leading: Radio(
                        value: i,
                        groupValue: feeFlag,
                        activeColor: AppColors.secondary,
                        onChanged: (value) {
                          setState(() {
                            feeFlag = int.parse(value.toString());
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            AppButtonWidget(
                texto: "Salvar",
                onPressed: () {
                  if (powerDeviceController.text.isNotEmpty &&
                      nameDeviceController.text.isNotEmpty) {
                    if (id == 0) {
                      var data = {
                        "name": nameDeviceController.text,
                        "power": int.tryParse(powerDeviceController.text),
                        "feeFlag": feeFlag
                      };
                      postData(Underwear.saveDevice, data).then((value) {
                        if (value['status'] == 'success') {
                          AppSnackBar().showSnack(context,
                              "Dispositivo cadastrado com sucesso!", 3);
                          clean();
                          Navigator.of(context).pop();
                        } else {
                          AppSnackBar().showSnack(context,
                              "Não foi possivel cadastrar seu Dispositivo!", 2);
                        }
                      }).catchError((e) {
                        AppSnackBar().showSnack(
                            context,
                            "Erro inesperado, Não foi possivel cadastrar seu Dispositivo!",
                            2);
                      });
                    } else {
                      var data = {
                        "id": id,
                        "name": nameDeviceController.text,
                        "power": int.tryParse(powerDeviceController.text),
                        "feeFlag": feeFlag
                      };
                      updateDevice(Underwear.saveDevice, data).then((value) {
                        if (value['status' == 'success']) {
                          AppSnackBar().showSnack(
                              context, "Dispositivo alterado com sucesso!", 3);
                          clean();
                          Navigator.of(context).pop();
                        } else {
                          AppSnackBar().showSnack(context,
                              "Não foi possivel alterar o dispositivo!", 3);
                        }
                      }).catchError((e) {
                        AppSnackBar().showSnack(
                            context,
                            "Erro inesperado, Não foi possivel alterar o dispositivo!",
                            3);
                      });
                    }
                  } else {
                    AppSnackBar()
                        .showSnack(context, "Preencha todos os campos!", 3);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
