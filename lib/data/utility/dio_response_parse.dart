import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entity/response/error_response.dart';
import 'dio_error_parse.dart';

extension DioResponse on Future<Response<dynamic>> {
  Future<Either<T, ErrorResponse>> consume<T>(Function fromJson) async {
    return then((value) async {
      return Left<T, ErrorResponse>(Function.apply(fromJson, [value.data]));
    }, onError: (error) async {
      if (error is DioError) {
        return Right<T, ErrorResponse>(parseDioError(error));
      }
      return Future<Either<T, ErrorResponse>>.error(
          Exception('Not a dio error'));
    });
  }
}