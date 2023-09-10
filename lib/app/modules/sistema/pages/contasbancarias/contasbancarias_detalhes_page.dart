// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../designSystem/layout/layoutComponent.dart';
import '../../../../designSystem/layout/titleComponent.dart';
import '../../../../designSystem/snackbarComponent.dart';
import '../../../../models/ContaBancariaModel.dart';
import 'contasbancarias_store.dart';

class ContasBancariasDetalhesPage extends StatefulWidget {
  late ContaBancariaModel contaBancaria;
  ContasBancariasDetalhesPage({
    super.key,
    required this.contaBancaria,
  });

  @override
  State<ContasBancariasDetalhesPage> createState() =>
      _ContasBancariasDetalhesPageState();
}

class _ContasBancariasDetalhesPageState
    extends State<ContasBancariasDetalhesPage> {
  late final ContasBancariasStore contasBancariasStore;

  @override
  void initState() {
    super.initState();

    contasBancariasStore = Modular.get<ContasBancariasStore>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      esconderDrawer: true,
      title: 'atualizar Conta Bancária',
      body: RefreshIndicator(
        onRefresh: () async {
          await contasBancariasStore.getContasBancarias();
        },
        child: Center(
          child: Column(
            children: [
              const TitleComponent(
                title: 'Alterando informações da conta bancária',
                subtitle:
                    'Use o formulário abaixo para ver ou alterar informações da conta bancária.',
              ),

              // Formulário
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          /*final resposta = await ContasBancariasStore.updateCliente(
                            ContaBancariaModel(
                              telefone: telefoneController.text,
                              id: idClienteController.text,
                              nome: nomeController.text,
                              documento: documentoController.text,
                              email: emailController.text,
                            ),
                          );

                          SnackBarComponent().showSuccess(context, resposta);*/
                          Modular.to.pushNamed('/sistema/contasbancarias');
                        } catch (e) {
                          SnackBarComponent().showError(context, e.toString());
                        }
                      },
                      child: const Text('Atualizar informações'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
