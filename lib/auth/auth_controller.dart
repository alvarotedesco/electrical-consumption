import 'dart:convert';

import 'package:electrical_comsuption/auth/auth_state.dart';
import 'package:electrical_comsuption/session_controller.dart';
import 'package:flutter/foundation.dart';

import '../http_util.dart';
import '../models/user.dart';
import '../themes/constants.dart';

class AuthController {
  final stateNotifier = ValueNotifier<AuthState>(AuthState.success);
  set state(AuthState state) => stateNotifier.value = state;
  AuthState get state => stateNotifier.value;

  var session = SessionController();

  Future<Map<String, dynamic>> login(UserModel user) async {
    state = AuthState.loading;
    var response = await HttpUtil().post(
      url: Underwear.loginURL,
      headers: {"Content-Type": "application/json"},
      data: user.toJson(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);

      session.token = resposta["token"];
      state = AuthState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = AuthState.error;
      return {"status": "error", "data": response.toString()};
    }
  }

  Future<Map<String, dynamic>> registry(UserModel user) async {
    state = AuthState.loading;
    var response = await HttpUtil().post(
      url: Underwear.registryURL,
      headers: {"Content-Type": "application/json"},
      data: user.toJson(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);

      session.token = resposta["token"];
      state = AuthState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = AuthState.error;
      return {"status": "error", "data": response.toString()};
    }
  }
}
