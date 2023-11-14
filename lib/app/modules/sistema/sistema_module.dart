import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/app_module.dart';

import '../../repositories/clientes/clientes_repository.dart';
import '../../repositories/clientes/clientes_repository_implementation.dart';
import 'pages/clientes/clientes_detalhes_page.dart';
import 'pages/clientes/clientes_novo_page.dart';
import 'pages/clientes/clientes_page.dart';
import 'pages/clientes/clientes_store.dart';
import 'pages/home_page.dart';

class SistemaModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<clientesRepository>(ClientesRepositoryImplementation.new);
    i.addSingleton<ClientesStore>(ClientesStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());

    r.child('/clientes', child: (context) => const ClientesPage());
    r.child('/clientes/novo', child: (context) => const ClientesNovoPage());
    r.child(
      '/clientes/detalhes',
      child: (context) => ClientesDetalhesPage(
        cliente: r.args.data,
      ),
    );

    r.wildcard(child: (context) => const HomePage());
  }
}
