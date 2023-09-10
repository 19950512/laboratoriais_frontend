// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../designSystem/layout/layoutComponent.dart';
import '../../../../models/ClientesModel.dart';
import '../../../../shared/stores/auth/auth_store.dart';
import 'clientes_store.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  late final ClientesStore clientesStore;
  late AuthStore _authStore;

  @override
  void initState() {
    super.initState();

    _authStore = Modular.get<AuthStore>();

    clientesStore = Modular.get<ClientesStore>();
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
      return const Center(child: Text('Nenhum cliente foi encontrado.'));
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
                              'Tem certeza que deseja excluir este cliente?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Modular.to.pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await clientesStore.deleteCliente(data);
                                Modular.to.pop();
                                clientesStore.getClientes();
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
                  '/sistema/clientes/detalhes',
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
      title: 'Clientes',
      actions: [
        IconButton(
          onPressed: () {
            Modular.to.pushNamed('/sistema/clientes/novo');
          },
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: clientesStore.getClientes,
          icon: const Icon(Icons.sync),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: clientesStore.getClientes,
        child: ScopedBuilder<ClientesStore, List<ClientesModel>>(
          store: clientesStore,
          onError: (context, erro) => _buildError(erro!),
          onLoading: (context) => _buildLoading(),
          onState: (context, state) => _buildSuccess(state),
        ),
      ),
    );
  }
}
