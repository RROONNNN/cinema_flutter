import 'package:cinema_flutter/model/services/auth_service.dart';
import 'package:cinema_flutter/shared/services/token_storage.dart';
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://192.168.137.1/api/v1/',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
  ),
);

void initDio() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add access token to all requests
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
          final refreshSuccess = await authService.refreshToken();

          if (refreshSuccess) {
            // Retry the original request with new token
            final newAccessToken = await TokenStorage.getAccessToken();
            error.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';

            try {
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
