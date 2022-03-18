import 'package:dartz/dartz.dart';

import '../../domain/entity/response/error_response.dart';
import '../../domain/entity/response/user_response.dart';
import '../../domain/repository/user_repository.dart';

import '../utility/dio_response_parse.dart';
import 'remote/api.dart';

class UserSource implements UserRepository {
  const UserSource(this.httpClient);

  final HttpClient httpClient;

  @override
  Future<Either<UserResponse, ErrorResponse>> getUsers(int limit, int page) {
    return httpClient.get('/user',
        queryParameters: <String, dynamic>{
          'limit': limit,
          'page': page
        }).consume<UserResponse>(UserResponse.fromMap);
  }
}