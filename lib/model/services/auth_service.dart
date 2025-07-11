import 'package:cinema_flutter/shared/services/token_storage.dart';
import 'package:cinema_flutter/shared/utils/http.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';

class AuthService {
  static AuthService? _instance;

  AuthService._internal();

  factory AuthService() {
    _instance ??= AuthService._internal();
    return _instance!;
  }

  Future<Map<String, String>> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    // Assuming the API returns a JSON object with accessToken and refreshToken
    final data = response.data;
    final accessToken = data['accessToken'] as String?;
    final refreshToken = data['refreshToken'] as String?;

    if (accessToken == null || refreshToken == null) {
      throw Exception('Login failed: Missing tokens in response');
    }

    await TokenStorage.storeTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    return {'accessToken': accessToken, 'refreshToken': refreshToken};
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await TokenStorage.getRefreshToken();
      if (refreshToken == null) {
        return false;
      }
      final response = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );
      final newAccessToken = response.data['accessToken'] as String?;
      final newRefreshToken = response.data['refreshToken'] as String?;
      if (newAccessToken != null && newRefreshToken != null) {
        await TokenStorage.storeTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Token refresh failed: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await dio.post(
        '/auth/logout',
        data: {'refreshToken': await TokenStorage.getRefreshToken()},
      );
    } catch (e) {
      debugPrint('Logout failed: $e');
    } finally {
      await TokenStorage.clearTokens();
    }
  }

  Future<bool> waitForUserActivation(
    String userId, {
    Duration timeout = const Duration(minutes: 5),
    Duration pollInterval = const Duration(seconds: 10),
  }) async {
    int attempts = 0;

    while (attempts < 6) {
      attempts++;
      try {
        final response = await dio.get(
          '/auth/getIsActive',
          queryParameters: {'userId': userId},
        );

        if (response.data['isActive'] == true) {
          return true; // User is now active
        }
        await Future.delayed(pollInterval);
      } catch (e) {
        debugPrint('Error polling getIsActive (attempt $attempts): $e');
        await Future.delayed(pollInterval);
      }
    }
    return false;
  }

  Future<bool> signUpWithActivation(
    String email,
    String password,
    String fullName,
    bool gender, {
    Duration timeout = const Duration(minutes: 5),
    Duration pollInterval = const Duration(seconds: 10),
  }) async {
    try {
      String genderString = (gender == true) ? "Male" : "Female";
      final response = await dio.post(
        '/auth/signup',
        data: {
          'email': email,
          'password': password,
          'fullName': fullName,
          'gender': genderString,
        },
      );
      await dio.post('/auth/send-verification-link', data: {'email': email});
      return await waitForUserActivation(
        response.data['id'],
        timeout: timeout,
        pollInterval: pollInterval,
      );
    } catch (e) {
      debugPrint('Signup failed: $e');
      return false;
    }
  }
}
