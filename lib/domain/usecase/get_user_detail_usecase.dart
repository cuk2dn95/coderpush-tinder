
import 'package:dartz/dartz.dart';
import '../entity/response/error_response.dart';
import '../entity/response/user_detail_response.dart';
import '../repository/user_repository.dart';


class GetUserDetailUseCase {
  GetUserDetailUseCase(this._repository);

  final UserRepository _repository;

  Future<Either<UserDetailResponse, ErrorResponse>> call(String id)  => _repository.getUserDetail(id);
}
