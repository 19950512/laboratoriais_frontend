import '../../models/ContaBancariaModel.dart';
import '../../shared/either.dart';
import '../../shared/services/httpClient/DIOHttpClientServiceImplementation.dart';
import '../../shared/services/httpClient/IHttpClientServiceInterface.dart';
import 'contasbancarias_repository.dart';

class ContasBancariasRepositoryImplementation
    implements ContasBancariasRepository {
  late final IHttpClientServiceInterface _httpClientService;

  ContasBancariasRepositoryImplementation() {
    _httpClientService = DIOHttpClientServiceImplementation();
  }

  @override
  Future<Either<String, List<ContaBancariaModel>>> getContasBancarias() async {
    final resposta = await _httpClientService.get(
      '/bankAccount',
    );

    return resposta.fold(
      (l) => Left(l),
      (r) => Right(
        r.data
            .map<ContaBancariaModel>((e) => ContaBancariaModel.fromJson(e))
            .toList(),
      ),
    );
  }
}
