import 'package:dio/dio.dart';
import '../../domain/entity/response/error_response.dart';

ErrorResponse parseDioError(DioError error){
    if(error.response != null) {
      return ErrorResponse(error.response!.statusCode ?? -1, error.message);
    } else {
      return ErrorResponse(-1, error.message);
    }
}