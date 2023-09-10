import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/app_module.dart';
import 'package:laboratoriais_frontend/app/modules/sistema/pages/contasbancarias/contasbancarias_store.dart';
import 'package:laboratoriais_frontend/app/repositories/contasBancarias/contas_bancarias_repository.dart';

import '../../repositories/clientes/clientes_repository.dart';
import '../../repositories/clientes/clientes_repository_implementation.dart';
import '../../repositories/contasBancarias/clientes_repository_implementation.dart';
import 'pages/clientes/clientes_detalhes_page.dart';
import 'pages/clientes/clientes_novo_page.dart';
import 'pages/clientes/clientes_page.dart';
import 'pages/clientes/clientes_store.dart';
import 'pages/contasbancarias/contasbancarias_novo_page.dart';
import 'pages/contasbancarias/contasbancarias_page.dart';
import 'pages/home_page.dart';

class SistemaModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<clientesRepository>(ClientesRepositoryImplementation.new);
    i.addSingleton<contasBancariasRepository>(
        ContasBancariasRepositoryImplementation.new);
    i.addSingleton<ClientesStore>(ClientesStore.new);
    i.addSingleton<ContasBancariasStore>(ContasBancariasStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());

    r.child('/contasbancarias',
        child: (context) => const ContasBancariasPage());
    r.child('/contasbancarias/novo',
        child: (context) => const ContasBancariasNovoPage());

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
