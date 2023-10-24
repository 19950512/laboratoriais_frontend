import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:laboratoriais_frontend/app/designSystem/snackbarComponent.dart';
import 'package:laboratoriais_frontend/app/shared/stores/auth/auth_store.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _nomeEmpresaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool loading = false;
  bool concordoComOsTermos = false;

  late AuthStore _authStore;

  @override
  void initState() {
    super.initState();
    _authStore = Modular.get<AuthStore>();

    _nomeEmpresaController.text = 'Empresa Teste';
    _emailController.text = 'mattmaydana@gmail.com';
    _senhaController.text = '102030405060';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Criando conta', style: TextStyle(fontSize: 30)),
                const SizedBox(height: 10),
                TextField(
                  controller: _nomeEmpresaController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da empresa',
                  ),
                ),
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
                Row(
                  children: [
                    Checkbox(
                      value: concordoComOsTermos,
                      onChanged: (value) {
                        setState(() {
                          concordoComOsTermos = value!;
                        });
                      },
                    ),
                    const Text('Li e concordo com os'),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/auth/termos'),
                      child: const Text('Termos de uso'),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: loading,
                  child: const CircularProgressIndicator.adaptive(),
                ),
                Visibility(
                  visible: !loading,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });

                      if (!concordoComOsTermos) {
                        SnackBarComponent().showError(context,
                            'Você precisa concordar com os termos de uso');
                        setState(() {
                          loading = false;
                        });
                        return;
                      }

                      final resposta = await _authStore.cadastrar(
                        name: _nomeEmpresaController.text,
                        email: _emailController.text,
                        password: _senhaController.text,
                      );

                      setState(() {
                        loading = false;
                      });

                      resposta.fold(
                        (l) => SnackBarComponent().showError(context, l),
                        (r) => Modular.to.navigate('/auth'),
                      );
                    },
                    child: const Text('Criar conta'),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Modular.to.navigate('/auth/create');
                  },
                  child: const Text('Não tem conta? Cadastre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
