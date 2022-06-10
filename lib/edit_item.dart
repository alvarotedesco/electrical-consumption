import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:electrical_comsuption/user_area.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';

class EditItem extends StatefulWidget {
  const EditItem({Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final nameDeviceController = TextEditingController();
  final powerDeviceController = TextEditingController();

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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class FilteringTextInputFormatter {}
