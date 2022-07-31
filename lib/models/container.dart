// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:electrical_comsuption/models/flag.dart';

class ContainerModel {
  final FlagModel flag;
  final String name;
  final int? id;

  ContainerModel({
    required this.flag,
    required this.name,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flag': flag.toMap(),
      'name': name,
      'id': id,
    };
  }

  factory ContainerModel.fromMap(Map<String, dynamic> map) {
    return ContainerModel(
      flag: FlagModel.fromMap(map['flag'] as Map<String, dynamic>),
      name: map['name'] as String,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerModel.fromJson(String source) =>
      ContainerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
