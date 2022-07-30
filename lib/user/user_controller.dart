import 'dart:convert';

import 'package:electrical_comsuption/http_util.dart';
import 'package:electrical_comsuption/user/user_state.dart';
import 'package:flutter/foundation.dart';

import '../themes/constants.dart';

class UserController {
  final stateNotifier = ValueNotifier<UserState>(UserState.empty);
  UserState get state => stateNotifier.value;
  set state(UserState state) => stateNotifier.value = state;

  Future<Map<String, dynamic>> getUserInfo() async {
    state = UserState.loading;
    var response = await HttpUtil().get(
      url: Underwear.getUserDataURL,
    );

    if (response.statusCode >= 200 || response.statusCode < 300) {
      var resposta = jsonDecode(response.body);

      state = UserState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = UserState.error;
      return {"status": "error", "data": response};
    }
  }
}
