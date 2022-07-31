import 'dart:convert';

import 'package:electrical_comsuption/http_util.dart';
import 'package:electrical_comsuption/models/user.dart';
import 'package:electrical_comsuption/user/user_state.dart';
import 'package:flutter/foundation.dart';

import '../themes/constants.dart';

class UserController {
  final stateNotifier = ValueNotifier<UserState>(UserState.empty);
  UserState get state => stateNotifier.value;
  set state(UserState state) => stateNotifier.value = state;

  UserModel? _user = UserModel(
    username: 'EmailTeste@outlook.com',
    cpf: '40556045807',
    name: 'Um Nome Qualquer Deteste',
  );

  UserModel? get user => _user;

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      state = UserState.loading;
      var response = await HttpUtil().get(
        url: Underwear.getUserDataURL,
      );

      if (response.statusCode == 200) {
        var resposta = jsonDecode(response.body);
        _user = UserModel.fromJson(resposta);

        state = UserState.success;
        return {"status": "success", "data": resposta};
      }

      state = UserState.error;
      return {"status": "error", "data": response};
    } on Exception {
      state = UserState.error;
      state = UserState.success; // TODO tirar isso
      return {"status": "error"};
    }
  }
}
