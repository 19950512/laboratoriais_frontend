import 'package:flutter_modular/flutter_modular.dart';
import '../../app_module.dart';
import 'pages/login_page.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
  }
}
