// ignore_for_file: camel_case_types

import '../../models/ClientesModel.dart';
import '../../shared/either.dart';

abstract class clientesRepository {
  Future<Either<String, List<ClientesModel>>> getClientes();
  Future<Either<String, ClientesModel>> addCliente(ClientesModel clientesModel);
  Future<Either<String, ClientesModel>> updateCliente(
    ClientesModel clientesModel,
  );
  Future<Either<String, ClientesModel>> deleteCliente(
    ClientesModel clientesModel,
  );
}
