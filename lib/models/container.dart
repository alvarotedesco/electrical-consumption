// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:electrical_comsuption/models/flag.dart';

class ContainerModel {
  final FlagModel? flag;
  final String name;
  final int flagId;
  final int? id;

  ContainerModel({
    required this.flagId,
    required this.name,
    this.flag,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flag': flag?.toMap(),
      'name': name,
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
      flagId: map['flag_id'] as int,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerModel.fromJson(String source) =>
      ContainerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
