import 'dart:convert';

import 'package:electrical_comsuption/auth/auth_state.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../themes/constants.dart';

class AuthController {
  final stateNotifier = ValueNotifier<AuthState>(AuthState.success);
  set state(AuthState state) => stateNotifier.value = state;
  AuthState get state => stateNotifier.value;

  Future<SharedPreferences> _pref() async =>
      await SharedPreferences.getInstance();

  Future<Map<String, dynamic>> login(UserModel user) async {
    var prefs = await _pref();
    Map<String, String> headers = {"Content-Type": "application/json"};

    state = AuthState.loading;
    var response = await http.post(
      Uri.parse('${Underwear.baseURL}${Underwear.loginURL}'),
      headers: headers,
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);

      prefs.setString("tokenjwt", resposta["token"]);
      state = AuthState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = AuthState.error;
      return {"status": "error", "data": response.toString()};
    }
  }

  Future<Map<String, dynamic>> registry(UserModel user) async {
    var prefs = await _pref();
    Map<String, String> headers = {"Content-Type": "application/json"};

    state = AuthState.loading;
    var response = await http.post(
      Uri.parse('${Underwear.baseURL}${Underwear.registryURL}'),
      headers: headers,
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);
      prefs.setString("tokenjwt", resposta["token"]);
      state = AuthState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = AuthState.error;
      return {"status": "error", "data": response.toString()};
    }
  }
}
