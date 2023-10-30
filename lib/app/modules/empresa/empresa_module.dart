import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/modules/empresa/pages/colaboradores/colaboradores_novo_page.dart';
import 'package:laboratoriais_frontend/app/modules/empresa/pages/colaboradores/colaboradores_page.dart';

import '../../app_module.dart';
import '../../repositories/empresa/empresa_repository.dart';
import '../../repositories/empresa/empresa_repository_implementation.dart';
import 'empresa_store.dart';
import 'pages/empresa_page.dart';

class EmpresaModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<EmpresaRepository>(EmpresaRepositoryImplementation.new);
    i.addSingleton<EmpresaStore>(EmpresaStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const EmpresaPage());
    r.child(
      '/colaboradores',
      child: (context) => const ColaboradoresPage(),
    );
    r.child(
      '/colaboradores/novo',
      child: (context) => const ColaboradoresNovoPage(),
    );
  }
}
