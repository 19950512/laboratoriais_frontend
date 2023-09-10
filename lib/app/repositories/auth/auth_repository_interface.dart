import '../../models/UserModel.dart';
import '../../shared/either.dart';

abstract class IAuthRepositoryInterface {
  Future<Either<String, UserModel>> login(String email, String password);
  void logout();
}
