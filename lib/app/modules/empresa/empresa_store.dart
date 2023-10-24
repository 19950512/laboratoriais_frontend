import 'dart:math';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:laboratoriais_frontend/app/models/ColaboradorModel.dart';

import '../../repositories/empresa/empresa_repository.dart';

class EmpresaStore extends Store<int> {
  final EmpresaRepository _repository;
  List<ColaboradorModel> colaboradores = [];

  EmpresaStore(this._repository) : super(0) {
    getColaboradores();
  }

  Future<void> getColaboradores() async {
    setLoading(true);
    try {
      final result = await _repository.getColaboradores();
      result.fold(
        (l) => setError(Exception(l)),
        (r) {
          colaboradores = r;
          update((Random(1)).nextInt(9999));
        },
      );
    } on Exception catch (e) {
      setError(e);
    }
    setLoading(false);
  }
}