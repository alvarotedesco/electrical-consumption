// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeviceModel {
  final double power;
  final String name;
  final int flag;
  final int id;

  DeviceModel({
    required this.power,
    required this.name,
    required this.flag,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'power': power,
      'name': name,
      'flag': flag,
      'id': id,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      power: map['power'] as double,
      name: map['name'] as String,
      flag: map['flag'] as int,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) =>
      DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
