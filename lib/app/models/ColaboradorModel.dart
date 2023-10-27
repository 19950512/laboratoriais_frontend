// ignore_for_file: file_names

class ColaboradorModel {
  late String id;
  late String nome;
  late String email;

  ColaboradorModel({
    required this.id,
    required this.nome,
    required this.email,
  });

  factory ColaboradorModel.fromJson(Map<String, dynamic> json) =>
      ColaboradorModel(
        id: json["code"] as String,
        nome: json["name"] as String,
        email: json["email"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "email": email,
      };
}
