// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:laboratoriais_frontend/app/models/ContaBancariaModel.dart';

import '../../../../designSystem/layout/layoutComponent.dart';
import '../../../../models/ClientesModel.dart';
import '../../../../shared/stores/auth/auth_store.dart';
import 'contasbancarias_store.dart';

class ContasBancariasPage extends StatefulWidget {
  const ContasBancariasPage({super.key});

  @override
  State<ContasBancariasPage> createState() => _ContasBancariasPageState();
}

class _ContasBancariasPageState extends State<ContasBancariasPage> {
  late final ContasBancariasStore contasBancariasStore;
  late AuthStore _authStore;

  @override
  void initState() {
    super.initState();

    _authStore = Modular.get<AuthStore>();

    contasBancariasStore = Modular.get<ContasBancariasStore>();
  }

  Widget _buildError(Exception state) {
    return Center(
      child: Text(state.toString()),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator.adaptive());
  }

  Widget _buildSuccess(state) {
    if (state.length == 0) {
      return const Center(
          child: Text('Nenhuma conta bancária foi encontrada.'));
    }

    return ListView.builder(
      itemCount: state.length,
      itemBuilder: (context, indexContexto) {
        ClientesModel data = state[indexContexto];
        return Card(
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  child: FlutterLogo(),
                ),
                title: Text(data.nome),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.email),
                    Text(data.documento),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Excluir'),
                          content: const Text(
                              'Tem certeza que deseja excluir esta conta bancária?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Modular.to.pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                //await contasBancariasStore.deleteCliente(data);
                                Modular.to.pop();
                                contasBancariasStore.getContasBancarias();
                              },
                              child: const Text('Excluir'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
                onTap: () => Modular.to.pushNamed(
                  '/sistema/contasbancarias/detalhes',
                  arguments: data,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      title: 'Contas Bancárias',
      actions: [
        IconButton(
          onPressed: () {
            Modular.to.pushNamed('/sistema/contasbancarias/novo');
          },
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: contasBancariasStore.getContasBancarias,
          icon: const Icon(Icons.sync),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: contasBancariasStore.getContasBancarias,
        child: ScopedBuilder<ContasBancariasStore, List<ContaBancariaModel>>(
          store: contasBancariasStore,
          onError: (context, erro) => _buildError(erro!),
          onLoading: (context) => _buildLoading(),
          onState: (context, state) => _buildSuccess(state),
        ),
      ),
    );
  }
}
