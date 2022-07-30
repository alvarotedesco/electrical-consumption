import 'dart:convert';

class ContainersModel {
  final String name;
  final int days;
  final int flag;
  final int? id;

  ContainersModel({
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

  factory ContainersModel.fromMap(Map<String, dynamic> map) {
    return ContainersModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      days: map['days'] as int,
      flag: map['flag'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainersModel.fromJson(String source) =>
      ContainersModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
