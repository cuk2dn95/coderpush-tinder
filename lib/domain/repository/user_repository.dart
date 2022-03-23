

import 'package:dartz/dartz.dart';
import '../entity/response/error_response.dart';
import '../entity/response/user_detail_response.dart';
import '../entity/response/user_response.dart';


abstract class UserRepository {
  Future<Either<UserResponse, ErrorResponse>> getUsers(int limit, int page);

  Future<Either<UserDetailResponse, ErrorResponse>> getUserDetail(String id);

  int? getCurrentUserPage();

  Future<void> saveCurrentUserPage(int page);
}