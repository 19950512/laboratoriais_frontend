import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../designSystem/snackbarComponent.dart';
import '../../../shared/stores/auth/auth_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  late AuthStore _authStore;

  @override
  void initState() {
    super.initState();
    _authStore = Modular.get<AuthStore>();

    _emailController.text = 'mattmaydana@gmail.com';
    _senhaController.text = 'qwertyqwerty';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Laboratoriais', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final resposta = await _authStore.logar(
                    email: _emailController.text,
                    password: _senhaController.text,
                  );

                  resposta.fold(
                    (l) => SnackBarComponent().showError(context, l),
                    (r) => Modular.to.navigate('/sistema/'),
                  );
                },
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
