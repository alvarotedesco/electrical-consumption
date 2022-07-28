import 'dart:convert';

import 'package:electrical_comsuption/user/user_state.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../themes/constants.dart';

class UserController {
  final stateNotifier = ValueNotifier<UserState>(UserState.empty);
  UserState get state => stateNotifier.value;
  set state(UserState state) => stateNotifier.value = state;

  Future<SharedPreferences> _pref() async =>
      await SharedPreferences.getInstance();

  Future<Map<String, dynamic>> getUserInfo() async {
    var token = ((await _pref()).getString("tokenjwt") ?? "");

    var response = await http.get(
      Uri.parse('${Underwear.baseURL}${Underwear.getUserDataURL}'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    ).catchError((e) {
      print('servidor desligado, Provavelmente');
    }).timeout(const Duration(seconds: 30));

    if (response.statusCode == 401) {}

    if (response.statusCode >= 200 || response.statusCode < 300) {
      var resposta = jsonDecode(response.body);

      return {"status": "success", "data": resposta};
    } else {
      return {"status": "error", "data": response};
    }
  }
}
