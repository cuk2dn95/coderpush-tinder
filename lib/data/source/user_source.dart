import 'dart:convert';

import 'package:coderpush_tinder/domain/entity/user.dart';
import 'package:dartz/dartz.dart';

import '../../common/database_key.dart';
import '../../domain/entity/response/error_response.dart';
import '../../domain/entity/response/user_detail_response.dart';
import '../../domain/entity/response/user_response.dart';
import '../../domain/repository/user_repository.dart';

import '../utility/dio_response_parse.dart';
import 'local/database.dart';
import 'remote/api.dart';

class UserSource implements UserRepository {
  const UserSource(this._httpClient, this._database);

  final HttpClient _httpClient;
  final Database _database;

  @override
  Future<Either<UserResponse, ErrorResponse>> getUsers(int limit, int page) {
    return _httpClient.get('/user', queryParameters: <String, dynamic>{
      'limit': limit,
      'page': page
    }).consume<UserResponse>(UserResponse.fromMap);
  }

  @override
  Future<Either<UserDetailResponse, ErrorResponse>> getUserDetail(String id) {
    return _httpClient
        .get(
          '/user/$id',
        )
        .consume<UserDetailResponse>(UserDetailResponse.fromMap);
  }

  @override
  int? getCurrentUserPage() {
    return _database.getValue<int>(DatabaseKey.currentPage);
  }

  @override
  Future<void> saveCurrentUserPage(int page) async {
    await _database
        .saveMapEntry(MapEntry<String, int>(DatabaseKey.currentPage, page));
  }

  @override
  Future<List<User>> getUsersByType(String type) async {
    final json = _database.getValue<String>(type);
    if (json == null) {
      return <User>[];
    }
    return jsonDecode(json)
        .map<User>((e) => User.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveUsersByType(String type, List<User> users) async {
    await _database
        .saveMapEntry(MapEntry<String, String>(type, jsonEncode(users.map((e) => e.toMap()).toList())));
  }
}
