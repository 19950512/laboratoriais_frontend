import 'dart:math';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:laboratoriais_frontend/app/models/ContaBancariaModel.dart';
import 'package:laboratoriais_frontend/app/repositories/contasBancarias/contasbancarias_repository.dart';

class ContasBancariasStore extends Store<int> {
  final ContasBancariasRepository _repository;
  List<ContaBancariaModel> contasbancarias = [];

  ContasBancariasStore(this._repository) : super(0) {
    getContasBancarias();
  }

  Future<void> getContasBancarias() async {
    setLoading(true);
    try {
      final result = await _repository.getContasBancarias();
      result.fold(
        (l) => setError(Exception(l)),
        (r) {
          contasbancarias = r;
          update((Random()).nextInt(99999));
        },
      );
    } on Exception catch (e) {
      setError(e);
    }
    setLoading(false);
  }
}
