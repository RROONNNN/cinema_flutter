part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticationSubscriptionRequested extends AuthEvent {
  const AuthenticationSubscriptionRequested();

  @override
  List<Object> get props => [];
}

final class AuthLogoutRequested extends AuthEvent {}
