import 'package:electrical_comsuption/API.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:electrical_comsuption/user_area.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API.dart';
import 'widgets/snackbar_widget.dart';

class EditItem extends StatefulWidget {
  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final nameDeviceController = TextEditingController();
  final powerDeviceController = TextEditingController();
  int id = 0;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((instance) {
      id = instance.getInt('idEdit');
      nameDeviceController.text = instance.getString('nameEdit');
      powerDeviceController.text = instance.getString('powerEdit');
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
            const SizedBox(height: 20),
            AppButtonWidget(
              texto: "Salvar",
              onPressed: () {
                if (powerDeviceController.text.isNotEmpty &&
                    nameDeviceController.text.isNotEmpty) {
                  var data = {
                    "id": id,
                    "name": nameDeviceController.text,
                    "power": int.tryParse(powerDeviceController.text)
                  };
                  postData(Underwear.saveDevice, data).then((value) {
                    if (value['status' == 'success']) {
                      AppSnackBar().showSnack(
                          context, "Dispositivo alterado com sucesso!", 3);
                      Navigator.of(context).pop();
                    } else {
                      AppSnackBar().showSnack(context,
                          "Não foi possivel alterar o dispositivo!", 3);
                    }
                  }).catchError((e) {
                    AppSnackBar().showSnack(
                        context, "Não foi possivel alterar o dispositivo!", 3);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
