import 'package:flutter_triple/flutter_triple.dart';

import '../../../../models/ContaBancariaModel.dart';
import '../../../../repositories/contasBancarias/contas_bancarias_repository.dart';

class ContasBancariasStore extends Store<List<ContaBancariaModel>> {
  final contasBancariasRepository _repository;

  ContasBancariasStore(this._repository) : super(<ContaBancariaModel>[]) {
    getContasBancarias();
  }

  Future<void> getContasBancarias() async {
    setLoading(true);
    try {
      final result = await _repository.getContasBancarias();
      result.fold(
        (l) => setError(Exception(l)),
        (r) => update(r),
      );
    } on Exception catch (e) {
      setError(e);
    }
    setLoading(false);
  }
}
