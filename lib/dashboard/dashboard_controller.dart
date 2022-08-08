import 'dart:convert';

import 'package:electrical_comsuption/models/container_device.dart';
import 'package:electrical_comsuption/session_controller.dart';
import 'package:flutter/material.dart';

import '../http_util.dart';
import '../themes/constants.dart';
import 'dashboard_state.dart';

class DashboardController {
  final stateNotifier = ValueNotifier<DashboardState>(DashboardState.empty);
  set state(DashboardState state) => stateNotifier.value = state;
  DashboardState get state => stateNotifier.value;

  final SessionController session = SessionController();

  List<ContainerDeviceModel> _data = [];

  List<ContainerDeviceModel> get data => _data;

  Future<Map<String, dynamic>> getContainerDevice() async {
    try {
      state = DashboardState.loading;
      var response = await HttpUtil()
          .get(url: '${Underwear.containersURL}/${session.container!.id}');

      if (response.statusCode == 200) {
        Map resposta = jsonDecode(response.body);

        List contDev = resposta['cont_dev'];

        _data = contDev
            .map((value) => ContainerDeviceModel.fromMap(value))
            .toList();

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
