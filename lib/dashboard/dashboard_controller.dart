import 'dart:convert';

import 'package:electrical_comsuption/models/container.dart';
import 'package:electrical_comsuption/models/container_device.dart';
import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/models/flag.dart';
import 'package:flutter/material.dart';

import '../http_util.dart';
import '../themes/constants.dart';
import 'dashboard_state.dart';

class DashboardController {
  final stateNotifier = ValueNotifier<DashboardState>(DashboardState.empty);
  set state(DashboardState state) => stateNotifier.value = state;
  DashboardState get state => stateNotifier.value;

  final List<ContainerDeviceModel> _data = [
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Churrasqueira elétrica',
        power: 2500,
      ),
      container: ContainerModel(
        name: 'Casa1',
        flagId: 1,
        flag: FlagModel(
          id: 1,
          name: 'Bandeira Verde',
          cost: 0,
          icon: 1,
        ),
      ),
      containerId: 1,
      deviceId: 1,
      consuDays: 30,
      consuTime: 2,
      quantity: 2,
    ),
  ];

  List<ContainerDeviceModel> get data => _data;

  Future<Map<String, dynamic>> getContainerDevice(int containerId) async {
    try {
      state = DashboardState.loading;
      var response = await HttpUtil().get(
        url: '${Underwear.containerDeviceURL}/$containerId',
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);

        state = DashboardState.success;
        return {"status": "success", "data": resposta};
      }

      state = DashboardState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = DashboardState.error;
      return {"status": "error"};
    }
  }
}
