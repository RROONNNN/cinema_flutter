import 'package:cinema_flutter/model/services/auth_service.dart';
import 'package:cinema_flutter/shared/services/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConfig {
  static final DioConfig _instance = DioConfig._internal();
  factory DioConfig() => _instance;
  DioConfig._internal() {
    initAllDio();
  }
  // static const String baseHost = '192.168.137.1';
  static const String baseHost = 'localhost';
  // Define your services with their ports
  final Map<String, int> _services = {
    'auth': 8001,
    'movie': 8002,
    'cinema': 8003,
    'showtime': 8004,
    'booking': 8005,
  };
  final Map<String, Dio> _dioServices = {};

  String _getServiceUrl(String serviceName) {
    final port = _services[serviceName];
    if (port == null) {
      throw Exception('Unknown service: $serviceName');
    }
    return 'http://$baseHost:$port/api/v1/';
  }

  void _initDio(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add access token to all requests
          debugPrint(
            '�� Request: ${options.baseUrl} ${options.method} ${options.path}',
          );
          final accessToken = await TokenStorage.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 errors by trying to refresh the token
          if (error.response?.statusCode == 401) {
            final authService = AuthService();
            bool refreshSuccess = false;
            try {
              refreshSuccess = await authService.refreshToken();
            } catch (e) {
              debugPrint('Token refresh failed: $e');
              refreshSuccess = false;
            }

            if (refreshSuccess) {
              // Retry the original request with new token
              try {
                final newAccessToken = await TokenStorage.getAccessToken();
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';

                final response = await dio.fetch(error.requestOptions);
                handler.resolve(response);
                return;
              } catch (e) {
                // If retry fails, logout user
                await authService.logout();
                handler.reject(error);
                return;
              }
            } else {
              // Refresh failed, logout user

              await authService.logout();
            }
          }
          handler.reject(error);
        },
      ),
    );
  }

  void initAllDio() {
    _services.forEach((key, value) {
      final dio = Dio(
        BaseOptions(
          baseUrl: _getServiceUrl(key),
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 15000),
        ),
      );
      _initDio(dio);
      _dioServices[key] = dio;
    });
  }

  Dio get authDio {
    if (!_dioServices.containsKey('auth')) {
      throw StateError('DioConfig not initialized. Call initAllDio() first.');
    }
    return _dioServices['auth']!;
  }

  Dio get movieDio {
    if (!_dioServices.containsKey('movie')) {
      throw StateError('DioConfig not initialized. Call initAllDio() first.');
    }
    return _dioServices['movie']!;
  }

  Dio get cinemaDio {
    if (!_dioServices.containsKey('cinema')) {
      throw StateError('DioConfig not initialized. Call initAllDio() first.');
    }
    return _dioServices['cinema']!;
  }

  Dio get showtimeDio {
    if (!_dioServices.containsKey('showtime')) {
      throw StateError('DioConfig not initialized. Call initAllDio() first.');
    }
    return _dioServices['showtime']!;
  }
}
