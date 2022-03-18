
import 'package:dartz/dartz.dart';
import '../entity/response/error_response.dart';
import '../entity/response/user_response.dart';
import '../repository/user_repository.dart';


class GetUsersUseCase {
  GetUsersUseCase(this.repository);

  final UserRepository repository;

  Future<Either<UserResponse, ErrorResponse>> call(int page, int limit)  => repository.getUsers(limit, page);
}
