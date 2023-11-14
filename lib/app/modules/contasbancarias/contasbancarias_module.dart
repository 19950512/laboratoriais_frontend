import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/repositories/contasBancarias/contasbancarias_repository.dart';
import 'package:laboratoriais_frontend/app/repositories/contasBancarias/contasbancarias_repository_implementation.dart';

import '../../app_module.dart';
import 'contasbancarias_store.dart';
import 'pages/contasbancarias_page.dart';

class ContasBancariasModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<ContasBancariasRepository>(
        ContasBancariasRepositoryImplementation.new);
    i.addSingleton<ContasBancariasStore>(ContasBancariasStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const ContasBancariasPage());
    r.child(
      '/contabancaria/novo',
      child: (context) => const ContasBancariasPage(),
    );
    r.child(
      '/contabancaria/detalhes',
      child: (context) => const ContasBancariasPage(),
    );
  }
}
