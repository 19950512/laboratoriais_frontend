import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  runApp(
    Container(
      color: Colors.white,
      child: const Center(child: CircularProgressIndicator.adaptive()),
    ),
  );

  /* INICIO */
  /* ISSO É PARA EVITAR QUE O APLICATIVO MUTE A ORIENTAÇÃO, PORTRAIT OU LANDSCAPE */
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  /* FIM */

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
