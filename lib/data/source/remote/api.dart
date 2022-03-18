import 'package:coderpush_tinder/data/constant.dart';
import 'package:dio/dio.dart';

class HttpClient {
  HttpClient() {
    dio = Dio();
    dio.options.baseUrl = AppConstant.baseUrl;
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers.addEntries(
              <String, dynamic>{'app-id': AppConstant.appId}.entries);
          handler.next(options);
        })
    );
  }

  late Dio dio;

  Future<Response<T>> get<T>(String path, {
    Map<String, dynamic>? queryParameters,
  }) => dio.get<T>(path, queryParameters: queryParameters);

  Future<Response<T>> post<T>(String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) => dio.post<T>(path, data: data, queryParameters: queryParameters);

  Future<Response<T>> put<T>(String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) => dio.put<T>(path, data: data, queryParameters: queryParameters);

  Future<Response<T>> delete<T>(String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) => dio.delete<T>(path, data: data, queryParameters: queryParameters);
}