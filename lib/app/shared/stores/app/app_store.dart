import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AppStore extends Store<int> {
  // Mantenha uma referência estática para a única instância da classe.
  // Construtor privado para evitar a criação de instâncias fora da classe.
  AppStore() : super(0);

  Brightness brightness = Brightness.light;
  bool fullScreen = false;

  void toggleFullScreen() {
    setLoading(true);
    fullScreen = !fullScreen;
    // Foi necessário colocar essa linha para que o ScopedBuilder reconheça a mudança de estado
    update(Random().nextInt(1000));
    setLoading(false);
  }

  void toggleBrightness() {
    setLoading(true);
    brightness =
        brightness == Brightness.light ? Brightness.dark : Brightness.light;

    // Foi necessário colocar essa linha para que o ScopedBuilder reconheça a mudança de estado
    update(Random().nextInt(1000));

    setLoading(false);
  }
}
