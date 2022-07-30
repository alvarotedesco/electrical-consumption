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

  List<DeviceModel> _listDevices = [];
  List<DeviceModel> get listDevices => _listDevices;

  Future<Map<String, dynamic>> createDevice(DeviceModel device) async {
    state = DeviceState.loading;
    var response = await HttpUtil().post(
      url: Underwear.createDeviceURL,
      data: device.toJson(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);

      state = DeviceState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = DeviceState.error;
      return {"status": "error", "data": response.statusCode};
    }
  }

  Future<Map<String, dynamic>> saveDevice(DeviceModel device) async {
    var response = await HttpUtil().post(
      url: Underwear.saveDeviceURL,
      data: device.toJson(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);

      return {"status": "success", "data": resposta};
    } else {
      return {"status": "error", "data": response.statusCode};
    }
  }

  Future<Map<String, dynamic>> listarDevices() async {
    state = DeviceState.loading;

    var response = await HttpUtil().get(
      url: Underwear.listDevicesURL,
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> resposta = jsonDecode(response.body);
      if (resposta.isEmpty) {
        state = DeviceState.empty;
        return {"status": "empty"};
      }

      _listDevices = resposta.map((e) => DeviceModel.fromMap(e)).toList();

      state = DeviceState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = DeviceState.error;
      return {"status": "error", "data": response.toString()};
    }
  }
}
