import 'dart:convert';

import 'package:electrical_comsuption/user/user_state.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../themes/constants.dart';

class PricipalController {
  // final stateNotifier = ValueNotifier<UserState>(UserState.empty);
  // UserState get state => stateNotifier.value;
  // set state(UserState state) => stateNotifier.value = state;

  Future<SharedPreferences> _pref() async =>
      await SharedPreferences.getInstance();

  Future<Map<String, dynamic>> postData(String url, data) async {
    var prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString("tokenjwt") ?? "");
    if (token != '') {
      data = json.encode(data);

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(Uri.parse('${Underwear.baseURL}$url'),
          headers: headers, body: data);

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

  Future<Map<String, dynamic>> postDevice(String url, data) async {
    var prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString("tokenjwt") ?? "");
    data = json.encode(data);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http.post(Uri.parse('${Underwear.baseURL}$url'),
        headers: headers, body: data);

    if (response.statusCode == 200) {
      return {"status": "success", "Message": "deu certo"};
    } else {
      return {"status": "error", "data": response.statusCode};
    }
  }
}
