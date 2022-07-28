import 'dart:convert';

class UserModel {
  final String? avatarUrl;
  final String? password;
  final String? username; // email
  final String? name;
  final String? cpf;

  UserModel({
    this.avatarUrl,
    this.password,
    this.username,
    this.name,
    this.cpf,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatarUrl': avatarUrl,
      'password': password,
      'username': username,
      'name': name,
      'cpf': cpf,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
