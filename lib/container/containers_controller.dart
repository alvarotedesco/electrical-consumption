import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/Containers.dart';
import '../themes/constants.dart';
import 'containers_state.dart';

class ContainersController {
  final stateNotifier = ValueNotifier<ContainersState>(ContainersState.success);
  ContainersState get state => stateNotifier.value;
  set state(ContainersState state) => stateNotifier.value = state;

  List<ContainersModel> _listContainers = [];
  List<ContainersModel> get listContainers => _listContainers;

  Future<SharedPreferences> _pref() async =>
      await SharedPreferences.getInstance();

  Future<Map<String, dynamic>> createContainer(
      ContainersModel container) async {
    var token = ((await _pref()).getString("tokenjwt") ?? "");
    if (token != '') {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(
          Uri.parse('${Underwear.baseURL}${Underwear.createContainerURL}'),
          headers: headers,
          body: container.toJson());

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

  Future<Map<String, dynamic>> listarContainers() async {
    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http.get(
        Uri.parse('${Underwear.baseURL}${Underwear.listContainersURL}'),
        headers: headers);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> resposta = jsonDecode(response.body);
      _listContainers =
          resposta.map((e) => ContainersModel.fromMap(e)).toList();

      return {"status": "success", "data": resposta};
    } else {
      return {"status": "error", "data": response.toString()};
    }
  }
}
