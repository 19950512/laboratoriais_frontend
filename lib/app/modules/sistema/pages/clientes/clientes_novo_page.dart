// ignore_for_file: use_build_context_synchronously

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../designSystem/layout/layoutComponent.dart';
import '../../../../designSystem/layout/titleComponent.dart';
import '../../../../designSystem/snackbarComponent.dart';
import '../../../../models/ClientesModel.dart';
import 'clientes_store.dart';

class ClientesNovoPage extends StatefulWidget {
  const ClientesNovoPage({super.key});

  @override
  State<ClientesNovoPage> createState() => _ClientesNovoPageState();
}

class _ClientesNovoPageState extends State<ClientesNovoPage> {
  late final ClientesStore clientesStore;

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController documentoController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    clientesStore = Modular.get<ClientesStore>();
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    documentoController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      esconderDrawer: true,
      title: 'Adicionar Cliente',
      body: Center(
        child: Column(
          children: [
            const TitleComponent(
              title: 'Adicionar Novo Cliente',
              subtitle:
                  'Use o formulário abaixo para adicionar um novo cliente.',
            ),

            // Formulário
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome completo',
                    ),
                  ),
                  TextFormField(
                    controller: documentoController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      labelText: 'CPF / CNPJ',
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
                  TextFormField(
                    controller: telefoneController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final resposta = await clientesStore.addCliente(
                          ClientesModel(
                            id: '',
                            telefone: telefoneController.text,
                            nome: nomeController.text,
                            documento: documentoController.text,
                            email: emailController.text,
                          ),
                        );

                        SnackBarComponent().showSuccess(context, resposta);
                        Modular.to.pushNamed('/sistema/clientes');
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
