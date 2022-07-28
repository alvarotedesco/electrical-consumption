// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContainersModel {
  final int? deviceNumber;
  final int? totalCost;
  final String? power;
  final String name;
  final int? id;

  ContainersModel({
    required this.name,
    this.deviceNumber,
    this.totalCost,
    this.power,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceNumber': deviceNumber,
      'totalCost': totalCost,
      'power': power,
      'name': name,
      'id': id,
    };
  }

  factory ContainersModel.fromMap(Map<String, dynamic> map) {
    return ContainersModel(
      deviceNumber:
          map['deviceNumber'] != null ? map['deviceNumber'] as int : null,
      totalCost: map['totalCost'] != null ? map['totalCost'] as int : null,
      power: map['power'] != null ? map['power'] as String : null,
      name: map['name'] as String,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainersModel.fromJson(String source) =>
      ContainersModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
