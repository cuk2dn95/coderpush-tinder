import 'package:coderpush_tinder/domain/response/error_response.dart';
import 'package:dartz/dartz.dart';

import '../response/user_response.dart';

abstract class UserRepository {
  Future<Either<UserResponse, ErrorResponse>> getUsers(int limit, int page);
}