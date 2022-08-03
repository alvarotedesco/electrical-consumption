import 'dart:convert';

import 'package:electrical_comsuption/models/device.dart';
import 'package:flutter/foundation.dart';

import '../http_util.dart';
import '../themes/constants.dart';
import 'device_state.dart';

class DeviceController {
  final stateNotifier = ValueNotifier<DeviceState>(DeviceState.success);
  set state(DeviceState state) => stateNotifier.value = state;
  DeviceState get state => stateNotifier.value;

  List<DeviceModel> _listDevices = [
    DeviceModel(power: 400, name: "nome de dispositivo"),
    DeviceModel(power: 500, name: "disposito500"),
    DeviceModel(power: 600, name: "disposito600"),
    DeviceModel(power: 700, name: "cavalo"),
    DeviceModel(power: 800, name: "camelo"),
    DeviceModel(power: 900, name: "melancia"),
    DeviceModel(power: 10000, name: "outra fruta aleatoria"),
    DeviceModel(power: 100, name: "penultimo dispositivo"),
    DeviceModel(power: 9, name: "lampada led"),
  ];
  List<DeviceModel> get listDevices => _listDevices;

  Future<Map<String, dynamic>> createDevice(DeviceModel device) async {
    try {
      state = DeviceState.loading;
      var response = await HttpUtil().post(
        url: Underwear.devicesURL,
        data: device.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> resposta = jsonDecode(response.body);

        state = DeviceState.success;
        return {"status": "success", "data": resposta};
      }

      state = DeviceState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = DeviceState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> saveDevice(DeviceModel device) async {
    try {
      state = DeviceState.loading;
      var response = await HttpUtil().put(
        url: Underwear.devicesURL,
        data: device.toJson(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);

        state = DeviceState.success;
        return {"status": "success", "data": resposta};
      }

      state = DeviceState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = DeviceState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> listarDevices() async {
    try {
      state = DeviceState.loading;
      var response = await HttpUtil().get(
        url: Underwear.devicesURL,
      );

      if (response.statusCode == 200) {
        List<dynamic> resposta = jsonDecode(response.body);
        if (resposta.isEmpty) {
          state = DeviceState.empty;
          return {"status": "empty"};
        }

        _listDevices = resposta.map((e) => DeviceModel.fromMap(e)).toList();

        state = DeviceState.success;
        return {"status": "success", "data": resposta};
      }

      state = DeviceState.error;
      return {"status": "error", "data": response.toString()};
    } on Exception {
      state = DeviceState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> deleteDevice(int id) async {
    try {
      state = DeviceState.loading;
      var response = await HttpUtil().delete(
        url: Underwear.devicesURL,
        data: id,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);

        state = DeviceState.success;
        return {"status": "success", "data": resposta};
      }

      state = DeviceState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = DeviceState.error;
      return {"status": "error"};
    }
  }
}
