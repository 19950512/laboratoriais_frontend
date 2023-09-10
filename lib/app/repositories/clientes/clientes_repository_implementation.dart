import '../../models/ClientesModel.dart';
import '../../shared/either.dart';
import '../../shared/services/httpClient/DIOHttpClientServiceImplementation.dart';
import '../../shared/services/httpClient/IHttpClientServiceInterface.dart';
import 'clientes_repository.dart';

class ClientesRepositoryImplementation implements clientesRepository {
  late final IHttpClientServiceInterface _httpClientService;

  ClientesRepositoryImplementation() {
    _httpClientService = DIOHttpClientServiceImplementation();
  }

  @override
  Future<Either<String, List<ClientesModel>>> getClientes() async {
    final resposta = await _httpClientService.get(
      '/client',
    );

    return resposta.fold(
      (l) => Left(l),
      (r) => Right(
        r.data.map<ClientesModel>((e) => ClientesModel.fromJson(e)).toList(),
      ),
    );
  }

  @override
  Future<Either<String, ClientesModel>> addCliente(
      ClientesModel clientesModel) async {
    final resposta = await _httpClientService.post(
      endpoint: '/client',
      body: {
        "name": clientesModel.nome,
        "email": clientesModel.email,
        "phone": clientesModel.telefone,
        "document": clientesModel.documento,
      },
    );

    return resposta.fold(
      (l) => Left(l),
      (r) => Right(clientesModel),
    );
  }

  @override
  Future<Either<String, ClientesModel>> updateCliente(
      ClientesModel clientesModel) async {
    final resposta = await _httpClientService.post(
      endpoint: '/client',
      body: {
        "id": clientesModel.id,
        "name": clientesModel.nome,
        "phone": clientesModel.telefone,
        "email": clientesModel.email,
        "document": clientesModel.documento,
      },
    );

    return resposta.fold(
      (l) => Left(l),
      (r) => Right(clientesModel),
    );
  }

  @override
  Future<Either<String, ClientesModel>> deleteCliente(
      ClientesModel clientesModel) async {
    final resposta =
        await _httpClientService.delete('/client?id=${clientesModel.id}');

    return resposta.fold(
      (l) => Left(l),
      (r) => Right(clientesModel),
    );
  }
}
