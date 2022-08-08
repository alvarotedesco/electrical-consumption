import 'dart:convert';

import 'package:electrical_comsuption/http_util.dart';
import 'package:electrical_comsuption/models/user.dart';
import 'package:electrical_comsuption/user/user_state.dart';
import 'package:flutter/foundation.dart';
import 'package:http/src/response.dart';

import '../themes/constants.dart';

class UserController {
  final stateNotifier = ValueNotifier<UserState>(UserState.empty);
  UserState get state => stateNotifier.value;
  set state(UserState state) => stateNotifier.value = state;

  UserModel? _user = UserModel(
    email: 'email_teste@outlook.com',
    cpf: '12456799632',
    name: 'Um Nome Qualquer De Teste',
  );

  UserModel? get user => _user;

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      state = UserState.loading;
      var response = await HttpUtil().get(
        url: Underwear.getUserURL,
      );

      if (response.statusCode == 200) {
        _user = UserModel.fromJson(response.body);

        state = UserState.success;
        return {"status": "success", "data": response.body};
      }

      state = UserState.error;
      return {"status": "error", "data": response};
    } on Exception {
      state = UserState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> updateUserV1Info(UserModel data) async {
    try {
      state = UserState.loading;
      var response = await HttpUtil().put(
        url: Underwear.updateUserV1URL,
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        // _user = UserModel.fromJson(response.body);

        state = UserState.success;
        return {"status": "success", "data": response.body};
      }

      state = UserState.error;
      return {"status": "error", "data": response};
    } on Exception {
      state = UserState.error;
      return {"status": "error"};
    }
  }
}
