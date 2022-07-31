// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class FlagModel {
  Icon icon;
  String name;
  double plus;
  int id;

  FlagModel({
    required this.name,
    required this.plus,
    required this.id,
    this.icon = const Icon(Icons.flag),
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'plus': plus,
      'icon': icon,
      'id': id,
    };
  }

  factory FlagModel.fromMap(Map<String, dynamic> map) {
    return FlagModel(
      name: map['name'] as String,
      plus: map['plus'] as double,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlagModel.fromJson(String source) =>
      FlagModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant FlagModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.plus == plus &&
        other.icon == icon &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ plus.hashCode ^ icon.hashCode ^ id.hashCode;
  }
}
