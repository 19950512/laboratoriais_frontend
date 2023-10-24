import 'package:flutter_modular/flutter_modular.dart';

import '../../models/UserModel.dart';
import '../../shared/either.dart';
import '../../shared/services/httpClient/DIOHttpClientServiceImplementation.dart';
import '../../shared/services/httpClient/IHttpClientServiceInterface.dart';
import '../../shared/stores/auth/auth_store.dart';
import 'auth_repository_interface.dart';

class AuthRepositoryImplementation implements IAuthRepositoryInterface {
  late final IHttpClientServiceInterface _httpClientService;

  AuthRepositoryImplementation() {
    _httpClientService = DIOHttpClientServiceImplementation();
  }

  @override
  Future<Either<String, UserModel>> login(String email, String password) async {
    final authStore = Modular.get<AuthStore>();
    authStore.setUser(UserModel(
      id: '-',
      email: email,
      name: 'User Name',
      foto: 'https://sis.gestorimob.com.br/jnh/app/user.png',
    ));

    final response = await _httpClientService.post(
      endpoint: '/auth/token',
      body: {
        'email': email,
        'password': password,
      },
    );

    return response.fold(
      (l) {
        return Left(l.toString());
      },
      (r) {
        if (r.data['access_token'] != null) {
          authStore.setAcessToken(r.data['access_token']);
        }

        return Right(UserModel(
          id: '-',
          email: email,
          name: 'User Name',
          foto: 'https://sis.gestorimob.com.br/jnh/app/user.png',
        ));
      },
    );
  }

  @override
  void logout() {}

  @override
  Future<Either<String, UserModel>> cadastrar(
    String email,
    String password,
    String name,
  ) async {
    final response = await _httpClientService.post(
      endpoint: '/auth/business',
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return response.fold(
      (l) {
        return Left(l.toString());
      },
      (r) {
        UserModel userModel = UserModel(
          id: r.data['id'],
          email: email,
          name: name,
          foto: 'https://sis.gestorimob.com.br/jnh/app/user.png',
        );

        return Right(userModel);
      },
    );
  }
}
