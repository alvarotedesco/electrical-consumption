// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:electrical_comsuption/models/flag.dart';
import 'package:electrical_comsuption/session_controller.dart';

class ContainerModel {
  final FlagModel? flag;
  final String name;
  final int? userId;
  final int flagId;
  final int? id;
  final double? kwTotal;
  final double? rsTotal;
  final int? qtdDevices;

  ContainerModel({
    required this.flagId,
    required this.name,
    this.userId,
    this.flag,
    this.id,
    this.kwTotal,
    this.rsTotal,
    this.qtdDevices,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flag': flag?.toMap(),
      'name': name,
      'user_id': userId ?? SessionController().userId,
      'flag_id': flagId,
      'id': id,
    };
  }

  factory ContainerModel.fromMap(Map<String, dynamic> map) {
    return ContainerModel(
      flag: map['flag'] != null
          ? FlagModel.fromMap(map['flag'] as Map<String, dynamic>)
          : null,
      name: map['name'] as String,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      flagId: map['flag_id'] as int,
      id: map['id'] != null ? map['id'] as int : null,
      kwTotal: map['kw_total'] != null ? (map['kw_total'] * 1.0) : null,
      rsTotal: map['rs_total'] != null ? (map['rs_total'] * 1.0) : null,
      qtdDevices: map['qtd_devices'] != null ? map['qtd_devices'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerModel.fromJson(String source) =>
      ContainerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
