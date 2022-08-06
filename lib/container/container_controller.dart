import 'dart:convert';

import 'package:electrical_comsuption/models/container.dart';
import 'package:flutter/material.dart';

import '../http_util.dart';
import '../models/flag.dart';
import '../themes/constants.dart';
import 'container_state.dart';

class ContainerController {
  final stateNotifier = ValueNotifier<ContainerState>(ContainerState.success);
  set state(ContainerState state) => stateNotifier.value = state;
  ContainerState get state => stateNotifier.value;

  List<ContainerModel> _listContainers = [];
  List<FlagModel> _dropFlags = [];

  List<ContainerModel> get listContainers => _listContainers;
  List<FlagModel> get dropFlags => _dropFlags;

  Future<Map<String, dynamic>> getFlags() async {
    try {
      state = ContainerState.loading;

      var response = await HttpUtil().get(
        url: Underwear.flagsURL,
      );

      if (response.statusCode == 200) {
        List resposta = jsonDecode(response.body);

        if (resposta.isEmpty) {
          state = ContainerState.empty;
          return {"status": "empty"};
        }

        _dropFlags = resposta.map((e) => FlagModel.fromMap(e)).toList();

        state = ContainerState.success;
        return {"status": "success", "data": resposta};
      }

      state = ContainerState.error;
      return {"status": "error", "data": 'response'.toString()};
    } on Exception {
      state = ContainerState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> createContainer(ContainerModel container) async {
    try {
      state = ContainerState.loading;
      var response = await HttpUtil().post(
        url: Underwear.containersURL,
        data: container.toJson(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);

        state = ContainerState.success;
        return {"status": "success", "data": resposta};
      }

      state = ContainerState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = ContainerState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> deleteContainer(int id) async {
    try {
      state = ContainerState.loading;
      var response = await HttpUtil().delete(
        url: Underwear.containersURL,
        data: id,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);
        state = ContainerState.success;
        return {"status": "success", "data": resposta};
      }

      state = ContainerState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = ContainerState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> saveContainer(ContainerModel container) async {
    try {
      state = ContainerState.loading;
      var response = await HttpUtil().put(
        url: "${Underwear.containersURL}/${container.id}",
        data: container.toJson(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body);
        state = ContainerState.success;
        return {"status": "success", "data": resposta};
      }

      state = ContainerState.error;
      return {"status": "error", "data": response.statusCode};
    } on Exception {
      state = ContainerState.error;
      return {"status": "error"};
    }
  }

  Future<Map<String, dynamic>> listarContainers() async {
    try {
      state = ContainerState.loading;
      var response = await HttpUtil().get(
        url: Underwear.containersURL,
      );

      _listContainers.clear();
      if (response.statusCode == 200) {
        List resposta = jsonDecode(response.body);

        if (resposta.isEmpty) {
          state = ContainerState.empty;
          return {"status": "empty"};
        }

        _listContainers =
            resposta.map((e) => ContainerModel.fromMap(e)).toList();

        state = ContainerState.success;
        return {"status": "success", "data": resposta};
      }

      state = ContainerState.error;
      return {"status": "error", "data": 'response'.toString()};
    } on Exception {
      state = ContainerState.error;
      return {"status": "error"};
    }
  }
}
