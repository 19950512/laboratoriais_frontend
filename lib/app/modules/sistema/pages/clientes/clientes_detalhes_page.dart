// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../designSystem/layout/layoutComponent.dart';
import '../../../../designSystem/layout/titleComponent.dart';
import '../../../../designSystem/snackbarComponent.dart';
import '../../../../models/ClientesModel.dart';
import 'clientes_store.dart';

class ClientesDetalhesPage extends StatefulWidget {
  late ClientesModel cliente;
  ClientesDetalhesPage({
    super.key,
    required this.cliente,
  });

  @override
  State<ClientesDetalhesPage> createState() => _ClientesDetalhesPageState();
}

class _ClientesDetalhesPageState extends State<ClientesDetalhesPage> {
  late final ClientesStore clientesStore;

  TextEditingController idClienteController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController documentoController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    idClienteController.text = widget.cliente.id;
    nomeController.text = widget.cliente.nome;
    emailController.text = widget.cliente.email;
    documentoController.text = widget.cliente.documento;
    telefoneController.text = widget.cliente.telefone;

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
      body: RefreshIndicator(
        onRefresh: () async {
          await clientesStore.getClientes();
        },
        child: Center(
          child: Column(
            children: [
              const TitleComponent(
                title: 'Alterando informações do cliente',
                subtitle:
                    'Use o formulário abaixo para ver ou alterar informações do cliente.',
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
                          final resposta = await clientesStore.updateCliente(
                            ClientesModel(
                              telefone: telefoneController.text,
                              id: idClienteController.text,
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
