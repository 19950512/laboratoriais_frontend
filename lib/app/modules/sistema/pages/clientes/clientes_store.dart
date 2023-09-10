import 'package:flutter_triple/flutter_triple.dart';

import '../../../../models/ClientesModel.dart';
import '../../../../repositories/clientes/clientes_repository.dart';
import '../../../../shared/errors/GenericException.dart';

class ClientesStore extends Store<List<ClientesModel>> {
  final clientesRepository _repository;

  ClientesStore(this._repository) : super(<ClientesModel>[]) {
    getClientes();
  }

  Future<void> getClientes() async {
    setLoading(true);
    try {
      final result = await _repository.getClientes();
      result.fold(
        (l) => setError(Exception(l)),
        (r) => update(r),
      );
    } on Exception catch (e) {
      setError(e);
    }
    setLoading(false);
  }

  Future<String> addCliente(ClientesModel clientesModel) async {
    final result = await _repository.addCliente(clientesModel);
    result.fold(
      (l) => {},
      (novoCliente) => update([...state, novoCliente]),
    );

    return result.fold((l) {
      throw GenericException(l);
    }, (r) => 'Cliente adicionado com sucesso');
  }

  Future<String> updateCliente(ClientesModel clientesModel) async {
    final result = await _repository.updateCliente(clientesModel);
    result.fold(
      (l) => {},
      (novoCliente) => {
        state[state.indexWhere((element) => element.id == novoCliente.id)] =
            novoCliente,
        update([...state])
      },
    );

    return result.fold((l) {
      throw GenericException(l);
    }, (r) => 'Cliente adicionado com sucesso');
  }

  Future<String> deleteCliente(ClientesModel clientesModel) async {
    final result = await _repository.deleteCliente(clientesModel);
    result.fold(
      (l) => {},
      (novoCliente) => {
        state.removeWhere((element) => element.id == novoCliente.id),
        update([...state])
      },
    );

    return result.fold((l) {
      throw GenericException(l);
    }, (r) => 'Cliente adicionado com sucesso');
  }
}
