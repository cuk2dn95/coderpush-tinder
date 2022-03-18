
import 'package:dartz/dartz.dart';
import '../entity/response/error_response.dart';
import '../entity/response/user_response.dart';
import '../repository/user_repository.dart';


class GetUsersUseCase {
  GetUsersUseCase(this._repository);

  final UserRepository _repository;

  Future<Either<UserResponse, ErrorResponse>> call(int page, int limit)  => _repository.getUsers(limit, page);
}
