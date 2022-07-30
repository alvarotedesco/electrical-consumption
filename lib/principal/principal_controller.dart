import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../http_util.dart';
import '../themes/constants.dart';
import 'principal_state.dart';

class PrincipalController {
  final stateNotifier = ValueNotifier<PrincipalState>(PrincipalState.empty);
  set state(PrincipalState state) => stateNotifier.value = state;
  PrincipalState get state => stateNotifier.value;

  Future<Map<String, dynamic>> getContainerDevice(int containerId) async {
    state = PrincipalState.loading;
    var response = await HttpUtil().get(
      url: '${Underwear.getContainerDevicesURL}/$containerId',
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);

      state = PrincipalState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = PrincipalState.error;
      return {"status": "error", "data": response.statusCode};
    }
  }
}
