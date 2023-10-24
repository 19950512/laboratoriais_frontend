import 'dart:math';

import 'package:flutter_triple/flutter_triple.dart';

import '../../../models/UserModel.dart';
import '../../../repositories/auth/auth_repository_interface.dart';
import '../../either.dart';

class AuthStore extends Store<int> {
  final IAuthRepositoryInterface _authRepository;

  AuthStore(this._authRepository) : super(0);

  bool isLoggedIn = false;
  String accessToken = '';

  UserModel user = UserModel(
    id: '-',
    email: 'user@email.com',
    name: 'User Name',
    foto: 'https://sis.gestorimob.com.br/jnh/app/user.png',
  );

  void removeAcessToken() {
    accessToken = '';
    isLoggedIn = false;
    update(Random().nextInt(100));
  }

  setUser(UserModel user) {
    this.user = user;
    isLoggedIn = true;
    update(Random().nextInt(100));
  }

  setAcessToken(String token) {
    accessToken = token;
    update(Random().nextInt(100));
  }

  Future<Either<String, UserModel>> logar(
      {required String email, required String password}) async {
    final resposta = _authRepository.login(email, password);

    return resposta;
  }

  Future<Either<String, UserModel>> cadastrar(
      {required String email,
      required String password,
      required String name}) async {
    final resposta = _authRepository.cadastrar(email, password, name);

    return resposta;
  }
}
