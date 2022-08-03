import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../http_util.dart';
import '../models/device.dart';
import '../themes/constants.dart';
import 'principal_state.dart';

class PrincipalController {
  final stateNotifier = ValueNotifier<PrincipalState>(PrincipalState.empty);
  set state(PrincipalState state) => stateNotifier.value = state;
  PrincipalState get state => stateNotifier.value;

  List<DeviceModel> _dropDevices = [
    // DeviceModel(power: 600.0, name: "ventilador", id: 1),
    // DeviceModel(power: 9.0, name: "Lampada LED", id: 2),
    // DeviceModel(power: 100.0, name: "Carregador Notebook", id: 3),
    // DeviceModel(power: 200.0, name: "Outro Item", id: 4),
    // DeviceModel(power: 1500.0, name: "Microondas", id: 5),
  ];
  List<DeviceModel> _containerDevices = [];
  final List<TextEditingController> _hoursControllers = [];
  final List<TextEditingController> _daysControllers = [];
  final List<TextEditingController> _qtdControllers = [];

  List<TextEditingController> get hoursControllers => _hoursControllers;
  List<TextEditingController> get daysControllers => _daysControllers;
  List<TextEditingController> get qtdControllers => _qtdControllers;
  List<DeviceModel> get containerDevices => _containerDevices;
  List<DeviceModel> get dropDevices => _dropDevices;

  void addDevice({DeviceModel? device, bool control = false}) {
    _hoursControllers.add(TextEditingController(text: '1'));
    _daysControllers.add(TextEditingController(text: '1'));
    _qtdControllers.add(TextEditingController(text: '1'));
    if (!control) _addDevice(device!);
  }

  void _addDevice(DeviceModel device) {
    _containerDevices.add(device);
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

        List devices = resposta['devices'];

        if (devices.isEmpty) {
          state = PrincipalState.empty;
          return {"status": "empty", "data": resposta};
        }

        _containerDevices = devices.map((e) {
          addDevice(control: true);
          return DeviceModel.fromMap(e);
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

  Future<Map<String, dynamic>> removeContainerDevice(
    int containerId,
    int deviceId,
  ) async {
    try {
      state = PrincipalState.loading;
      var response = await HttpUtil().delete(
        url: '${Underwear.deleteContainerDeviceURL}/$containerId/$deviceId',
      );

      if (response.statusCode == 200) {
        getContainerDevice(containerId);

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
}
