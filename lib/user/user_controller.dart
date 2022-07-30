import 'dart:convert';

import 'package:electrical_comsuption/http_util.dart';
import 'package:electrical_comsuption/user/user_state.dart';
import 'package:flutter/foundation.dart';

import '../themes/constants.dart';

class UserController {
  final stateNotifier = ValueNotifier<UserState>(UserState.empty);
  UserState get state => stateNotifier.value;
  set state(UserState state) => stateNotifier.value = state;

  String _userName = '';
  String _userCpf = '';
  String _userMail = '';

  String get userName => _userName;
  String get userCpf => _userCpf;
  String get userMail => _userMail;

  Future<Map<String, dynamic>> getUserInfo() async {
    state = UserState.loading;
    var response = await HttpUtil().get(
      url: Underwear.getUserDataURL,
    );

    if (response.statusCode >= 200 || response.statusCode < 300) {
      var resposta = jsonDecode(response.body);
      _userName = resposta["name"];
      _userCpf = resposta["cpf"];
      _userMail = resposta["username"];

      state = UserState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = UserState.error;
      return {"status": "error", "data": response};
    }
  }
}
