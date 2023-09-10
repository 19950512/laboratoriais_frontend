import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/modules/configuracoes/configuracoes_module.dart';
import 'package:laboratoriais_frontend/app/modules/sistema/sistema_module.dart';

import 'app_splash_page.dart';
import 'modules/auth/auth_module.dart';
import 'repositories/auth/auth_repository_implementation.dart';
import 'repositories/auth/auth_repository_interface.dart';
import 'shared/stores/app/app_store.dart';
import 'shared/stores/auth/auth_store.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<AppStore>(AppStore.new);
    i.addSingleton<IAuthRepositoryInterface>(AuthRepositoryImplementation.new);
    i.addSingleton<AuthStore>(AuthStore.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const AppSplashPage(),
    );
    r.module('/auth', module: AuthModule());
    r.module('/sistema', module: SistemaModule());
    r.module('/configuracoes', module: ConfiguracoesModule());
  }
}
