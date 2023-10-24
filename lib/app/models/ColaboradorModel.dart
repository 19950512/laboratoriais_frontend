// ignore_for_file: file_names
import 'dart:convert';

class ColaboradorModel {
  late String id;
  late String nome;
  late String email;

  ColaboradorModel({
    required this.id,
    required this.nome,
    required this.email,
  });

  ColaboradorModel copyWith({
    String? id,
    String? nome,
    String? email,
  }) {
    return ColaboradorModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'email': email,
    };
  }

  factory ColaboradorModel.fromMap(Map<String, dynamic> map) {
    return ColaboradorModel(
      id: map['id'] as String,
      nome: map['nome'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColaboradorModel.fromJson(String source) =>
      ColaboradorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
