// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/shared/stores/auth/auth_store.dart';

import '../../../designSystem/layout/layoutComponent.dart';
import '../../../shared/stores/app/app_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppStore _appStore;
  late final AuthStore _authStore;

  @override
  void initState() {
    super.initState();

    _appStore = Modular.get<AppStore>();
    _authStore = Modular.get<AuthStore>();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      title: 'Home',
      esconderDrawer: false,
      body: Center(
        child: Column(
          children: [
            const Text('Lorem ipsum dollors'),
            ElevatedButton(
              onPressed: () => Modular.to.pushNamed('/sistema/clientes'),
              child: const Text('Clique aqui'),
            ),
            ElevatedButton(
              onPressed: () {
                _appStore.toggleFullScreen();
              },
              child: const Text('Clique aqui'),
            ),
          ],
        ),
      ),
    );
  }
}
