import 'dart:convert';

import 'package:electrical_comsuption/models/container.dart';
import 'package:flutter/material.dart';

import '../http_util.dart';
import '../models/flag.dart';
import '../themes/app_colors.dart';
import '../themes/constants.dart';
import 'container_state.dart';

class ContainerController {
  final stateNotifier = ValueNotifier<ContainerState>(ContainerState.success);
  set state(ContainerState state) => stateNotifier.value = state;
  ContainerState get state => stateNotifier.value;

  List<ContainerModel> _listContainers = [
    ContainerModel(
      flag: FlagModel(
        id: 1,
        name: 'Bandeira Verde',
        plus: 0,
        icon: Icon(Icons.flag, color: AppColors.green),
      ),
      name: 'Apartamento',
    ),
    ContainerModel(
      flag: FlagModel(
        id: 2,
        name: 'Bandeira Amarela',
        plus: 0.01874,
        icon: Icon(Icons.flag, color: AppColors.yellow),
      ),
      name: 'Mansão',
    ),
    ContainerModel(
      flag: FlagModel(
        id: 3,
        name: 'Bandeira Vermelha P.1',
        plus: 0.03971,
        icon: Icon(Icons.flag, color: AppColors.red),
      ),
      name: 'Casa',
    ),
  ];

  List<FlagModel> dropFlags = [
    FlagModel(
      id: 1,
      name: 'Bandeira Verde',
      plus: 0,
      icon: Icon(Icons.flag, color: AppColors.green),
    ),
    FlagModel(
      id: 2,
      name: 'Bandeira Amarela',
      plus: 0.01874,
      icon: Icon(Icons.flag, color: AppColors.yellow),
    ),
    FlagModel(
      id: 3,
      name: 'Bandeira Vermelha P.1',
      plus: 0.03971,
      icon: Icon(Icons.flag, color: AppColors.red),
    ),
    FlagModel(
      id: 4,
      name: 'Bandeira Vermelha P.2',
      plus: 0.09492,
      icon: Icon(Icons.flag, color: AppColors.darkRed),
    ),
    FlagModel(
      id: 5,
      name: 'Bandeira Escassez Hídrica',
      plus: 0.1420,
      icon: Icon(Icons.flag, color: AppColors.grey),
    ),
  ];

  List<ContainerModel> get listContainers => _listContainers;

  Future<Map<String, dynamic>> createContainer(ContainerModel container) async {
    try {
      state = ContainerState.loading;
      var response = await HttpUtil().post(
        url: Underwear.createContainerURL,
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
        url: Underwear.createContainerURL,
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
      var response = await HttpUtil().post(
        url: Underwear.saveContainerURL,
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
        url: Underwear.listContainersURL,
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> resposta = jsonDecode(response.body);

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

      state = ContainerState.success;
      return {"status": "error"};
    }
  }
}
