import 'dart:convert';

class Utilizador {
  final String username;
  final String password;

  Utilizador({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };

  @override
  String toString() => jsonEncode(toJson());
}
