import 'dart:convert';

import 'package:electrical_comsuption/models/device.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/constants.dart';
import 'device_state.dart';

class DeviceController {
  final stateNotifier = ValueNotifier<DeviceState>(DeviceState.success);
  DeviceState get state => stateNotifier.value;
  set state(DeviceState state) => stateNotifier.value = state;

  List<DeviceModel> _listDevices = [];
  List<DeviceModel> get listDevices => _listDevices;

  Future<SharedPreferences> _pref() async =>
      await SharedPreferences.getInstance();

  Future<Map<String, dynamic>> createDevice(DeviceModel device) async {
    var token = ((await _pref()).getString("tokenjwt") ?? "");
    if (token != '') {
      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(
          Uri.parse('${Underwear.baseURL}${Underwear.createDeviceURL}'),
          headers: headers,
          body: device.toJson());

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);

        return {"status": "success", "data": resposta};
      } else {
        return {"status": "error", "data": response.statusCode};
      }
    } else {
      return {
        "status": "error",
        "data": "Token Expirado, faça o Login novamente!!"
      };
    }
  }

  Future<Map<String, dynamic>> saveDevice(DeviceModel device) async {
    var token = ((await _pref()).getString("tokenjwt") ?? "");
    if (token != '') {
      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(
          Uri.parse('${Underwear.baseURL}${Underwear.saveDeviceURL}'),
          headers: headers,
          body: device.toJson());

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);

        return {"status": "success", "data": resposta};
      } else {
        return {"status": "error", "data": response.statusCode};
      }
    } else {
      return {
        "status": "error",
        "data": "Token Expirado, faça o Login novamente!!"
      };
    }
  }

  Future<Map<String, dynamic>> listarDevices() async {
    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http.get(
        Uri.parse('${Underwear.baseURL}${Underwear.listDevicesURL}'),
        headers: headers);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> resposta = jsonDecode(response.body);
      _listDevices = resposta.map((e) => DeviceModel.fromMap(e)).toList();

      return {"status": "success", "data": resposta};
    } else {
      return {"status": "error", "data": response.toString()};
    }
  }
}
