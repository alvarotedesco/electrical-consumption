import 'dart:convert';

class DeviceModel {
  final String? description;
  final double power;
  final String name;
  final int? id;

  DeviceModel({
    required this.power,
    required this.name,
    this.description,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      id: map['id'] != null ? map['id'] as int : null,
      power: map['power'] as double,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) =>
      DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
