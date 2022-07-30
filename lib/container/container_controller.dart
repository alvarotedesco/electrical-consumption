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
    ContainerModel(days: 20, flag: 1, name: 'Apartamento'),
    ContainerModel(days: 30, flag: 2, name: 'Mansão'),
    ContainerModel(days: 30, flag: 3, name: 'Casa'),
  ];

  List<FlagModel> dropFlags = [
    FlagModel(
      id: 0,
      name: 'Bandeira Verde',
      icon: Icon(Icons.flag, color: AppColors.green),
    ),
    FlagModel(
      id: 1,
      name: 'Bandeira Amarela',
      icon: Icon(Icons.flag, color: AppColors.orange),
    ),
    FlagModel(
      id: 2,
      name: 'Bandeira Vermelha P.1',
      icon: Icon(Icons.flag, color: AppColors.red),
    ),
    FlagModel(
      id: 3,
      name: 'Bandeira Vermelha P.2',
      icon: Icon(Icons.flag, color: AppColors.red),
    ),
    FlagModel(
      id: 4,
      name: 'Bandeira Escassez hidrica',
      icon: Icon(Icons.flag, color: AppColors.black),
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
