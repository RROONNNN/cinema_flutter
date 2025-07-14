import 'dart:async';

import 'package:cinema_flutter/model/services/auth_service.dart';
import 'package:flutter/foundation.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  static AuthRepository? _instance;
  final AuthService _authService = AuthService();
  final _controller = StreamController<AuthenticationStatus>.broadcast();
  AuthRepository._();

  static AuthRepository get instance {
    _instance ??= AuthRepository._();
    _instance!._controller.add(AuthenticationStatus.unknown);
    return _instance!;
  }

  Future<void> signUpWithActivation({
    required String email,
    required String password,
    String? fullName,
    bool? gender,
  }) async {
    try {
      await _authService.signUpWithActivation(
        email,
        password,
        fullName ?? "User",
        gender ?? true,
      );
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      debugPrint('Signup failed: $e');
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _authService.login(email: email, password: password);
      _controller.add(AuthenticationStatus.authenticated);
      debugPrint('Login success');
    } catch (e) {
      debugPrint('Login failed: $e');
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> logOut() async {
    try {
      await _authService.logout();
      _controller.add(AuthenticationStatus.unauthenticated);
    } catch (e) {
      debugPrint('Logout failed: $e');
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }
}
