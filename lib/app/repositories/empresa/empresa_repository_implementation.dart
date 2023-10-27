import 'package:laboratoriais_frontend/app/models/ColaboradorModel.dart';
import 'package:laboratoriais_frontend/app/shared/services/httpClient/DIOHttpClientServiceImplementation.dart';

import '../../shared/either.dart';
import '../../shared/services/httpClient/IHttpClientServiceInterface.dart';
import 'empresa_repository.dart';

class EmpresaRepositoryImplementation implements EmpresaRepository {
  late final IHttpClientServiceInterface _httpClientService;

  EmpresaRepositoryImplementation() {
    _httpClientService = DIOHttpClientServiceImplementation();
  }

  @override
  Future<Either<String, List<ColaboradorModel>>> getColaboradores() async {
    final resposta = await _httpClientService.get(
      '/business/colaboradores',
    );

    return resposta.fold(
      (l) => Left(l),
      (r) {
        return Right(
          r.data
              .map<ColaboradorModel>((e) => ColaboradorModel.fromJson(e))
              .toList(),
        );
      },
    );
  }
}
