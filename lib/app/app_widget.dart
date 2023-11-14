// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();

    setTripleResolver(tripleResolverCallback);
  }

  T tripleResolverCallback<T extends Object>() {
    return Modular.get<T>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Laboratoriais',
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blue,
      ),
    );
  }
}
