import 'package:coderpush_tinder/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import '../response/error_response.dart';
import '../response/user_response.dart';

class GetUsersUseCase {
  GetUsersUseCase(this.repository);

  final UserRepository repository;

  Future<Either<UserResponse, ErrorResponse>> call(int page, int limit)  => repository.getUsers(limit, page);
}
