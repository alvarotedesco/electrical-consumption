import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../http_util.dart';
import '../models/device.dart';
import '../themes/constants.dart';
import 'principal_state.dart';

class PrincipalController {
  final stateNotifier = ValueNotifier<PrincipalState>(PrincipalState.empty);
  set state(PrincipalState state) => stateNotifier.value = state;
  PrincipalState get state => stateNotifier.value;

  List<DeviceModel> _dropDevices = [
    DeviceModel(power: 600.0, name: "ventilador", id: 1),
    DeviceModel(power: 9.0, name: "Lampada LED", id: 2),
    DeviceModel(power: 100.0, name: "Carregador Notebook", id: 3),
    DeviceModel(power: 200.0, name: "Outro Item", id: 4),
    DeviceModel(power: 1500.0, name: "Microondas", id: 5),
  ];

  List<DeviceModel> get dropDevices => _dropDevices;

  Future<Map<String, dynamic>> getContainerDevice(int containerId) async {
    try {
      state = PrincipalState.loading;
      var response = await HttpUtil().get(
        url: '${Underwear.getContainerDevicesURL}/$containerId',
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);

        state = PrincipalState.success;
        return {"status": "success", "data": resposta};
      }

      state = PrincipalState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = PrincipalState.error;
      return {"status": "error"};
    }
  }
}
