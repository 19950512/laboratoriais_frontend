// ignore_for_file: use_build_context_synchronously

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/models/ColaboradorModel.dart';
import 'package:laboratoriais_frontend/app/modules/empresa/empresa_store.dart';
import 'package:laboratoriais_frontend/app/modules/empresa/empresa_store.dart';

import '../../../../designSystem/layout/layoutComponent.dart';
import '../../../../designSystem/layout/titleComponent.dart';
import '../../../../designSystem/snackbarComponent.dart';
import '../../../../models/ClientesModel.dart';

class ColaboradoresNovoPage extends StatefulWidget {
  const ColaboradoresNovoPage({super.key});

  @override
  State<ColaboradoresNovoPage> createState() => _ColaboradoresNovoPageState();
}

class _ColaboradoresNovoPageState extends State<ColaboradoresNovoPage> {
  late final EmpresaStore empresaStore;

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    empresaStore = Modular.get<EmpresaStore>();
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      esconderDrawer: true,
      title: 'Adicionar Colaborador',
      body: Center(
        child: Column(
          children: [
            const TitleComponent(
              title: 'Adicionar Novo Colaborador',
              subtitle:
                  'Use o formulário abaixo para adicionar um novo colaborador.',
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
                    controller: emailController,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final resposta = await empresaStore.addColaborador(
                          ColaboradorModel(
                            id: '',
                            email: emailController.text,
                            nome: nomeController.text,
                          ),
                        );

                        SnackBarComponent().showSuccess(context, resposta);
                        Modular.to.pushNamed('/empresa/colaboradores');
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
