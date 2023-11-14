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
  String cnab = "240";
  String saldo = "0";
  ContaBancariaModel({
    required this.id,
    required this.nome,
    required this.conta,
    required this.cedente,
    required this.agencia,
    required this.posto,
    required this.banco,
    required this.cnab,
    required this.saldo,
  });

  factory ContaBancariaModel.fromJson(Map<String, dynamic> json) =>
      ContaBancariaModel(
        id: json["id"] as String,
        nome: json["nome"] as String,
        conta: json["conta"] as String,
        cedente: json["cedente"] as String,
        agencia: json["agencia"] as String,
        posto: json["posto"] as String,
        banco: json["banco"] as String,
        cnab: json["cnab"] as String,
        saldo: (json["saldo"] ?? "0") as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "conta": conta,
        "cedente": cedente,
        "agencia": agencia,
        "posto": posto,
        "banco": banco,
        "cnab": cnab,
        "saldo": saldo,
      };
}
