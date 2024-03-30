import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/core/exceptions/dio_exception.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioManager {
  static String baseUrl =
      dotenv.env['BASE_URL'] ?? "https://api.themoviedb.org/3";
  static String apiKey = dotenv.env['API_KEY'] ?? '';
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    queryParameters: {
      'api_key': apiKey,
    },
  ))
    ..interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
        DioExceptions dioExceptions = DioExceptions.fromDioError(error);

        Failure failure = Failure(message: dioExceptions.message);
        if (kDebugMode) {
          print(failure.message);
        }

        return handler.next(error);
      },
    ));

  static Dio getDio() {
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger());
    }
    return _dio;
  }
}
