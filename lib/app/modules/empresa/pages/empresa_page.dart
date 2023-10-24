import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:laboratoriais_frontend/app/shared/stores/auth/auth_store.dart';

import '../../../designSystem/layout/layoutComponent.dart';
import '../../../designSystem/switchComponent.dart';
import '../../../shared/stores/app/app_store.dart';

class EmpresaPage extends StatefulWidget {
  const EmpresaPage({super.key});

  @override
  State<EmpresaPage> createState() => _EmpresaPageState();
}

class _EmpresaPageState extends State<EmpresaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      title: 'Empresa',
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            GestureDetector(
              onTap: () => Modular.to.pushNamed('/empresa/colaboradores'),
              child: const Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people),
                    Text('Colaboradores'),
                  ],
                ),
              ),
            ),
            const Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.business),
                  Text('Informações Empresa'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
