import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/modules/auth/pages/create_page.dart';
import 'package:laboratoriais_frontend/app/modules/auth/pages/termos_de_uso_page.dart';
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
    r.child('/create', child: (context) => const CreatePage());
    r.child('/termos', child: (context) => const TermosDeUsoPage());
  }
}
