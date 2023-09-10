import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import 'configuracoes_store.dart';
import 'pages/configuracoes_page.dart';

class ConfiguracoesModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<ConfiguracoesStore>(ConfiguracoesStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const ConfiguracoesPage());
  }
}
