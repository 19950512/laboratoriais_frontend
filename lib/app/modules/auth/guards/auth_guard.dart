import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/home/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    return true;
  }
}
