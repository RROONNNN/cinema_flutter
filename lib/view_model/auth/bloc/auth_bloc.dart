import 'package:bloc/bloc.dart';
import 'package:cinema_flutter/model/repositories/auth_repository.dart';
import 'package:cinema_flutter/model/services/user_service.dart';
import 'package:cinema_flutter/view_model/auth/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authenticationRepository;

  AuthBloc({required AuthRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository,
      super(AuthState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onAuthRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    return emit.onEach(
      _authenticationRepository.status,
      onData: (status) async {
        debugPrint('AuthBloc: $status');
        switch (status) {
          case AuthenticationStatus.authenticated:
            final user = await UserService().getProfile();
            emit(AuthState.authenticated(user));
          case AuthenticationStatus.unauthenticated:
            emit(AuthState.unauthenticated());
          case AuthenticationStatus.unknown:
            emit(AuthState.unknown());
        }
      },
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    _authenticationRepository.logOut();
    emit(AuthState.unauthenticated());
  }
}
