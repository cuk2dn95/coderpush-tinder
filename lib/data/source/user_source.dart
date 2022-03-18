
import 'package:coderpush_tinder/domain/repository/user_repository.dart';
import 'package:coderpush_tinder/domain/response/error_response.dart';
import 'package:coderpush_tinder/domain/response/user_response.dart';
import 'package:dartz/dartz.dart';

class UserSource implements UserRepository {
  @override
  Future<Either<UserResponse, ErrorResponse>> getUsers(int limit, int page) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

}