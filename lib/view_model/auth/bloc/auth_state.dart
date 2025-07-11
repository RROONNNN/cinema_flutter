part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthenticationStatus status;
  final User user;
  const AuthState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });
  const AuthState.unknown() : this._();
  const AuthState.authenticated(User user)
    : this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthState.unauthenticated()
    : this._(status: AuthenticationStatus.unauthenticated);

  bool get isAuthenticated => status == AuthenticationStatus.authenticated;
  bool get isUnauthenticated => status == AuthenticationStatus.unauthenticated;
  bool get isUnknown => status == AuthenticationStatus.unknown;

  @override
  List<Object?> get props => [status, user];

  //copyWith
  AuthState copyWith({AuthenticationStatus? status, User? user}) {
    return AuthState._(status: status ?? this.status, user: user ?? this.user);
  }
}
