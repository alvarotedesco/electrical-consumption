import 'dart:convert';

class UserModel {
  final String? avatarUrl;
  final String? password;
  final String email; // email
  final String? name;
  final String? cpf;
  final String? newPassword;
  final String? newEmail;

  UserModel({
    required this.email,
    this.avatarUrl,
    this.password,
    this.name,
    this.cpf,
    this.newPassword,
    this.newEmail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatarUrl': avatarUrl,
      'password': password,
      'email': email,
      'name': name,
      'cpf': cpf,
      'newPassword': newPassword,
      'newEmail': newEmail,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      email: map['email'] as String,
      newPassword:
          map['newPassword'] != null ? map['newPassword'] as String : null,
      newEmail: map['newEmail'] != null ? map['newEmail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
