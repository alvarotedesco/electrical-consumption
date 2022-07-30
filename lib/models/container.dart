import 'dart:convert';

class ContainerModel {
  final String name;
  final int days;
  final int flag;
  final int? id;

  ContainerModel({
    required this.days,
    required this.flag,
    required this.name,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'days': days,
      'flag': flag,
      'name': name,
      'id': id,
    };
  }

  factory ContainerModel.fromMap(Map<String, dynamic> map) {
    return ContainerModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      days: map['days'] as int,
      flag: map['flag'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerModel.fromJson(String source) =>
      ContainerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
