// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../shared/stores/auth/auth_store.dart';

class DrawerMenuComponent extends StatelessWidget {
  late AuthStore authStore;

  Widget _buildError(erro) {
    return Center(
      child: Text(erro.toString()),
    );
  }

  Widget _buildLoading() {
    return _header();
  }

  Widget _header() {
    authStore = Modular.get<AuthStore>();
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/logo_menudraw.png"),
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
              ),
            ),
            accountName: Text(
              authStore.user.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              authStore.user.email,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: Image.network(authStore.user.foto).image,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess() {
    return _header();
  }

  @override
  Widget build(BuildContext context) {
    double tamanhoDraw = 190.0;
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: tamanhoDraw,
            child: ScopedBuilder<AuthStore, int>(
              onError: (context, erro) => _buildError(erro!),
              onLoading: (context) => _buildLoading(),
              onState: (context, state) => _buildSuccess(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - tamanhoDraw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text("Início"),
                  subtitle: const Text("boas vindas"),
                  onTap: () => Modular.to.pushNamed('/sistema/'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.people,
                  ),
                  title: const Text("Clientes"),
                  subtitle: const Text("Gerenciar clientes"),
                  onTap: () => Modular.to.pushNamed('/sistema/clientes'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.attach_money,
                  ),
                  title: const Text("Contas Bancarias"),
                  subtitle: const Text("Gerenciar Contas Bancarias"),
                  onTap: () => Modular.to.pushNamed('/sistema/contasbancarias'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                  ),
                  title: const Text("Configurações"),
                  subtitle: const Text("Configurações do sistema"),
                  onTap: () => Modular.to.pushNamed('/configuracoes/'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                  ),
                  title: const Text("sair"),
                  subtitle: const Text("fechar o software"),
                  onTap: () => SystemNavigator.pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
