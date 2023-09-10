// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: file_names

class ContaBancariaModel {
  String id;
  String nome;
  String conta;
  String cedente;
  String agencia;
  String posto;
  String banco;
  int cnab = 240;
  ContaBancariaModel({
    required this.id,
    required this.nome,
    required this.conta,
    required this.cedente,
    required this.agencia,
    required this.posto,
    required this.banco,
    required this.cnab,
  });

  ContaBancariaModel copyWith({
    String? id,
    String? nome,
    String? conta,
    String? cedente,
    String? agencia,
    String? posto,
    String? banco,
    int? cnab,
  }) {
    return ContaBancariaModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      conta: conta ?? this.conta,
      cedente: cedente ?? this.cedente,
      agencia: agencia ?? this.agencia,
      posto: posto ?? this.posto,
      banco: banco ?? this.banco,
      cnab: cnab ?? this.cnab,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'conta': conta,
      'cedente': cedente,
      'agencia': agencia,
      'posto': posto,
      'banco': banco,
      'cnab': cnab,
    };
  }

  factory ContaBancariaModel.fromMap(Map<String, dynamic> map) {
    return ContaBancariaModel(
      id: map['id'] as String,
      nome: map['nome'] as String,
      conta: map['conta'] as String,
      cedente: map['cedente'] as String,
      agencia: map['agencia'] as String,
      posto: map['posto'] as String,
      banco: map['banco'] as String,
      cnab: map['cnab'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContaBancariaModel.fromJson(String source) =>
      ContaBancariaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContaBancariaModel(id: $id, nome: $nome, conta: $conta, cedente: $cedente, agencia: $agencia, posto: $posto, banco: $banco, cnab: $cnab)';
  }

  @override
  bool operator ==(covariant ContaBancariaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.conta == conta &&
        other.cedente == cedente &&
        other.agencia == agencia &&
        other.posto == posto &&
        other.banco == banco &&
        other.cnab == cnab;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        conta.hashCode ^
        cedente.hashCode ^
        agencia.hashCode ^
        posto.hashCode ^
        banco.hashCode ^
        cnab.hashCode;
  }
}
