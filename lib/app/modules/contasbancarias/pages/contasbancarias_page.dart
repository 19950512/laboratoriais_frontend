import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:laboratoriais_frontend/app/models/ContaBancariaModel.dart';
import 'package:laboratoriais_frontend/app/modules/contasbancarias/contasbancarias_store.dart';

import '../../../designSystem/layout/layoutComponent.dart';
import '../../../designSystem/switchComponent.dart';
import '../../../shared/stores/app/app_store.dart';

class ContasBancariasPage extends StatefulWidget {
  const ContasBancariasPage({super.key});

  @override
  State<ContasBancariasPage> createState() => _ContasBancariasPageState();
}

class _ContasBancariasPageState extends State<ContasBancariasPage> {
  late final AppStore _appStore;
  late final ContasBancariasStore contasBancariasStore;

  @override
  void initState() {
    super.initState();

    _appStore = Modular.get<AppStore>();
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
    if (contasBancariasStore.contasbancarias.isEmpty) {
      return const Center(child: Text('Nenhum colaborador foi encontrado.'));
    }
    return ListView.builder(
      itemCount: contasBancariasStore.contasbancarias.length,
      itemBuilder: (context, indexContexto) {
        ContaBancariaModel data =
            contasBancariasStore.contasbancarias[indexContexto];
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
                    Text('Banco: ${data.banco}'),
                    Text('Agência: ${data.agencia}'),
                  ],
                ),
                trailing: Column(
                  children: [
                    Text('Saldo: ${data.saldo}'),
                  ],
                ),
                onTap: () => Modular.to.pushNamed(
                  './contabancaria/detalhes',
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
      esconderDrawer: true,
      actions: [
        IconButton(
          onPressed: () {
            Modular.to.pushNamed('./novo');
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
        child: ScopedBuilder<ContasBancariasStore, int>(
          store: contasBancariasStore,
          onError: (context, erro) => _buildError(erro!),
          onLoading: (context) => _buildLoading(),
          onState: (context, state) => _buildSuccess(state),
        ),
      ),
    );
  }
}
