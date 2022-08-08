import 'dart:convert';

import 'package:electrical_comsuption/models/container_device.dart';
import 'package:flutter/material.dart';

import '../http_util.dart';
import '../models/device.dart';
import '../themes/constants.dart';
import 'principal_state.dart';

class PrincipalController {
  final stateNotifier = ValueNotifier<PrincipalState>(PrincipalState.empty);
  set state(PrincipalState state) => stateNotifier.value = state;
  PrincipalState get state => stateNotifier.value;

  List<DeviceModel> _dropDevices = [];
  List<DeviceModel> _containerDevices = [];
  final List<TextEditingController> _hoursControllers = [];
  final List<TextEditingController> _daysControllers = [];
  final List<TextEditingController> _qtdControllers = [];

  List<TextEditingController> get hoursControllers => _hoursControllers;
  List<TextEditingController> get daysControllers => _daysControllers;
  List<TextEditingController> get qtdControllers => _qtdControllers;
  List<DeviceModel> get containerDevices => _containerDevices;
  List<DeviceModel> get dropDevices => _dropDevices;

  int containerId = 0;

  void addDevice({
    DeviceModel? device,
    ContainerDeviceModel? contDev,
    bool control = false,
  }) {
    for (var i = 0; i < _containerDevices.length; i++) {
      if (_containerDevices[i].id == device!.id) {
        _qtdControllers[i].text =
            (int.parse(_qtdControllers[i].text) + 1).toString();
        return;
      }
    }

    _hoursControllers.add(TextEditingController(
        text: contDev != null ? contDev.consuTime.toString() : '1'));
    _daysControllers.add(TextEditingController(
        text: contDev != null ? contDev.consuDays.toString() : '1'));
    _qtdControllers.add(TextEditingController(
        text: contDev != null ? contDev.quantity.toString() : '1'));

    if (!control) {
      _containerDevices.add(device!);
      makeDataToSave();
    }
  }

  void makeDataToSave() {
    var data = <String, Map<String, Map<String, String>>>{'devices': {}};

    for (var i = 0; i < _containerDevices.length; i++) {
      data['devices']![_containerDevices[i].id.toString()] = {
        'consu_time': _hoursControllers[i].text,
        'consu_days': _daysControllers[i].text,
        'quantity': _qtdControllers[i].text
      };
    }

    saveContainerDevice(data);
  }

  Future<Map<String, dynamic>> getContainerDevice(int containerId) async {
    try {
      state = PrincipalState.loading;
      var response = await HttpUtil().get(
        url: '${Underwear.containersURL}/$containerId',
      );

      _containerDevices.clear();
      if (response.statusCode == 200) {
        Map resposta = jsonDecode(response.body);

        List contDevs = resposta['cont_dev'];

        if (contDevs.isEmpty) {
          state = PrincipalState.empty;
          return {"status": "empty", "data": resposta};
        }

        _containerDevices = contDevs.map((contDev) {
          addDevice(
              contDev:
                  ContainerDeviceModel.fromMap(contDev as Map<String, dynamic>),
              control: true);
          return DeviceModel.fromMap(contDev['device']);
        }).toList();

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

  Future<Map<String, dynamic>> getDevices() async {
    try {
      state = PrincipalState.loading;
      var response = await HttpUtil().get(
        url: Underwear.devicesURL,
      );

      _dropDevices.clear();
      if (response.statusCode == 200) {
        List devices = jsonDecode(response.body);

        if (devices.isEmpty) {
          state = PrincipalState.empty;
          return {"status": "empty", "data": devices};
        }

        _dropDevices = devices.map((e) => DeviceModel.fromMap(e)).toList();

        state = PrincipalState.loading;
        state = PrincipalState.success;
        return {"status": "success", "data": devices};
      }

      state = PrincipalState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = PrincipalState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> saveContainerDevice(data) async {
    try {
      state = PrincipalState.loading;
      var response = await HttpUtil().put(
        url: '${Underwear.containersURL}/$containerId',
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        state = PrincipalState.success;
        return {"status": "success", "data": response.body};
      }

      state = PrincipalState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = PrincipalState.error;
      return {"status": "error"};
    }
  }

//   Future<Map<String, dynamic>> removeContainerDevice(int deviceId) async {
//     try {
//       state = PrincipalState.loading;
//       var response = await HttpUtil().delete(
//         url: '${Underwear.containerDeviceURL}/$containerId/$deviceId',
//       );

//       if (response.statusCode == 200) {
//         getContainerDevice(containerId);

//         state = PrincipalState.success;
//         return {"status": "success", "data": response.body};
//       }

//       state = PrincipalState.error;
//       return {"status": "error", "data": response.statusCode};
//     } on Exception {
//       state = PrincipalState.error;
//       return {"status": "error"};
//     }
//   }
}
