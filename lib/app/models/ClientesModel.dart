// ignore_for_file: file_names

class ClientesModel {
  late String id;
  late String nome;
  late String documento;
  late String email;
  late String telefone;

  ClientesModel({
    required this.id,
    required this.nome,
    required this.documento,
    required this.email,
    required this.telefone,
  });

  factory ClientesModel.fromJson(Map<String, dynamic> json) => ClientesModel(
        id: json["id"],
        nome: json["nome"],
        documento: json["documento"],
        email: json["email"],
        telefone: json["telefone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "documento": documento,
        "email": email,
        "telefone": telefone,
      };
}
