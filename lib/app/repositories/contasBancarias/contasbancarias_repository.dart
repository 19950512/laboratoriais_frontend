// ignore_for_file: camel_case_types

import 'package:laboratoriais_frontend/app/models/ContaBancariaModel.dart';

import '../../shared/either.dart';

abstract class ContasBancariasRepository {
  Future<Either<String, List<ContaBancariaModel>>> getContasBancarias();
}
