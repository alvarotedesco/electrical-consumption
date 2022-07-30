import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../http_util.dart';
import '../models/Containers.dart';
import '../themes/constants.dart';
import 'containers_state.dart';

class ContainersController {
  final stateNotifier = ValueNotifier<ContainersState>(ContainersState.success);
  set state(ContainersState state) => stateNotifier.value = state;
  ContainersState get state => stateNotifier.value;

  List<ContainersModel> _listContainers = [];
  List<ContainersModel> get listContainers => _listContainers;

  Future<Map<String, dynamic>> createContainer(
      ContainersModel container) async {
    state = ContainersState.loading;
    var response = await HttpUtil().post(
      url: Underwear.createContainerURL,
      data: container.toJson(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);
      state = ContainersState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = ContainersState.error;
      return {"status": "error", "data": response.statusCode};
    }
  }

  Future<Map<String, dynamic>> listarContainers() async {
    state = ContainersState.loading;
    var response = await HttpUtil().get(
      url: Underwear.listContainersURL,
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> resposta = jsonDecode(response.body);

      _listContainers =
          resposta.map((e) => ContainersModel.fromMap(e)).toList();

      state = ContainersState.success;
      return {"status": "success", "data": resposta};
    } else {
      state = ContainersState.error;
      return {"status": "error", "data": response.toString()};
    }
  }
}
