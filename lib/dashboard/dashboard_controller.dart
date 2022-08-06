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

  List<ContainerDeviceModel> _data = [
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
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Chuveiro Elétrico',
        power: 5000,
        id: 2,
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
      deviceId: 2,
      consuDays: 30,
      consuTime: 0.33,
      quantity: 2,
    ),
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Condicionador de Ar',
        power: 1400,
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
      deviceId: 3,
      consuDays: 30,
      consuTime: 6,
      quantity: 2,
    ),
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Máquina de Lavar Roupa',
        power: 1000,
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
      deviceId: 4,
      consuDays: 30,
      consuTime: 2,
      quantity: 1,
    ),
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Televisor',
        power: 90,
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
      deviceId: 5,
      consuDays: 30,
      consuTime: 2,
      quantity: 3,
    ),
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Liquidificador',
        power: 200,
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
      deviceId: 6,
      consuDays: 30,
      consuTime: 16,
      quantity: 1,
    ),
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Computador',
        power: 450,
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
      deviceId: 7,
      consuDays: 30,
      consuTime: 8,
      quantity: 3,
    ),
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Lâmpada LED',
        power: 9,
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
      deviceId: 8,
      consuDays: 30,
      consuTime: 10,
      quantity: 9,
    ),
    ContainerDeviceModel(
      device: DeviceModel(
        name: 'Geladeira',
        power: 350,
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
      deviceId: 9,
      consuDays: 30,
      consuTime: 24,
      quantity: 1,
    ),
  ];

  List<ContainerDeviceModel> get data => _data;

  Future<Map<String, dynamic>> getContainerDevice(int containerId) async {
    try {
      state = DashboardState.loading;
      var response = await HttpUtil().get(
        url: '${Underwear.containersURL}/$containerId',
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
