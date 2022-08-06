import 'dart:convert';

class FlagModel {
  int icon;
  String name;
  double cost;
  int id;

  FlagModel({
    required this.name,
    required this.cost,
    required this.id,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cost': cost,
      'icon': icon,
      'id': id,
    };
  }

  factory FlagModel.fromMap(Map<String, dynamic> map) {
    return FlagModel(
      icon: map['icon'] as int,
      name: map['name'] as String,
      cost: map['cost'] as double,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlagModel.fromJson(String source) =>
      FlagModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
