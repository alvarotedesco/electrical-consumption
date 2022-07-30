import 'package:electrical_comsuption/device/device_controller.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../widgets/snackbar_widget.dart';
import 'device_area.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  DeviceController controller = DeviceController();

  var dropDevices;

  void _newDevice() {
    Navigator.pushNamed(
      context,
      '/novo-dispositivo',
    ).then((v) {
      controller.listarDevices().then((resp) {
        if (resp['status'] == 'success') {
          setState(() {
            dropDevices = resp['data']["content"];
          });
        } else {
          AppSnackBar().showSnack(context, "Erro ao pegar os dados");
        }
      }).catchError((e) {
        AppSnackBar()
            .showSnack(context, "Erro inesperado, Erro ao pegar os dados");
      });
    });
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.height * 0.3);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: CustomAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: _newDevice,
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Meus Dispositivos',
                  style: AppTextStyles.defaultStyleB,
                ),
              ),
              SizedBox(
                height: height,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Lista ${index + 1}'),
                        subtitle: Text('40 (W)'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
