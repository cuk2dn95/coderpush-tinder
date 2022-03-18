import 'package:coderpush_tinder/data/constant.dart';
import 'package:dio/dio.dart';

class HttpClient {
  HttpClient() {
    _dio = Dio();
    _dio.options.baseUrl = AppConstant.baseUrl;
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers.addEntries(
              <String, dynamic>{'app-id': AppConstant.appId}.entries);
          handler.next(options);
        })
    );
  }

  late Dio _dio;

  Future<Response<T>> get<T>(String path, {
    Map<String, dynamic>? queryParameters,
  }) => _dio.get<T>(path, queryParameters: queryParameters);

  Future<Response<T>> post<T>(String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) => _dio.post<T>(path, data: data, queryParameters: queryParameters);

  Future<Response<T>> put<T>(String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) => _dio.put<T>(path, data: data, queryParameters: queryParameters);

  Future<Response<T>> delete<T>(String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) => _dio.delete<T>(path, data: data, queryParameters: queryParameters);
}