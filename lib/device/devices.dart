import 'package:electrical_comsuption/device/device_controller.dart';
import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/widgets/floating_button_widget.dart';
import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../widgets/snackbar_widget.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  DeviceController controller = DeviceController();

  DeviceModel? _selectedDevice;

  void _newDevice() {
    Navigator.pushNamed(
      context,
      '/novo-dispositivo',
    );
  }

  void _init() {
    controller.listarDevices().then((resp) {
      if (resp['status'] != 'success') {
        AppSnackBar().showSnack(context, "Erro ao pegar os dados");
        return;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    _init();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.height * 0.3);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        floatingActionButton: FloatingCustomButtonWidget(
          onNewButton: _newDevice,
          onEditButton: () {
            Navigator.of(context)
                .pushNamed('/editar-dispositivo', arguments: _selectedDevice);
          },
          onDeleteButton: () async {
            await controller.deleteDevice(_selectedDevice!.id as int);
            _init();
          },
          selected: _selectedDevice != null,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: height,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: controller.listDevices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        selected:
                            _selectedDevice == controller.listDevices[index],
                        selectedTileColor:
                            _selectedDevice == controller.listDevices[index]
                                ? AppColors.secondary
                                : null,
                        onLongPress: () {
                          setState(() {
                            _selectedDevice = controller.listDevices[index];
                          });
                        },
                        onTap: () {
                          Navigator.of(context).pushNamed('/editar-dispositivo',
                              arguments: controller.listDevices[index]);
                        },
                        title: Text(
                          controller.listDevices[index].name,
                          style:
                              _selectedDevice == controller.listDevices[index]
                                  ? AppTextStyles.h1WhiteBold
                                  : AppTextStyles.h3BlackBold,
                        ),
                        subtitle: Text(
                          '${controller.listDevices[index].power} W',
                          style:
                              _selectedDevice == controller.listDevices[index]
                                  ? AppTextStyles.h2WhiteBold
                                  : AppTextStyles.h4black,
                        ),
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
