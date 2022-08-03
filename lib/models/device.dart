// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:electrical_comsuption/session_controller.dart';

class DeviceModel {
  final String? description;
  final double power;
  final int? userId;
  final String name;
  final int? id;

  DeviceModel({
    required this.power,
    required this.name,
    this.description,
    this.userId,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId ?? SessionController().userId,
      'description': description,
      'power': power,
      'name': name,
      'id': id,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      description:
          map['description'] != null ? map['description'] as String : null,
      power: map['power'] as double,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      name: map['name'] as String,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) =>
      DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
