// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../designSystem/layout/layoutComponent.dart';
import '../../../../designSystem/layout/titleComponent.dart';
import '../../../../designSystem/snackbarComponent.dart';
import 'contasbancarias_store.dart';

class ContasBancariasNovoPage extends StatefulWidget {
  const ContasBancariasNovoPage({super.key});

  @override
  State<ContasBancariasNovoPage> createState() =>
      _ContasBancariasNovoPageState();
}

class _ContasBancariasNovoPageState extends State<ContasBancariasNovoPage> {
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
      title: 'Adicionar nova conta bancária',
      body: Center(
        child: Column(
          children: [
            const TitleComponent(
              title: 'Adicionar nova conta bancária',
              subtitle:
                  'Use o formulário abaixo para adicionar uma nova conta bancária.',
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
                        /* final resposta = await ContasBancariasStore.addCliente(
                          ClientesModel(
                            id: '',
                            telefone: telefoneController.text,
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
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
