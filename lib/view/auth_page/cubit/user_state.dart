part of 'user_cubit.dart';

final class UserState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final FullName fullName;
  final bool gender;
  final bool isValid;
  final bool isActivationInProgress;
  final Duration activationElapsed;
  final String? activationError;

  const UserState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.fullName = const FullName.pure(),
    this.gender = true,
    this.isValid = false,
    this.isActivationInProgress = false,
    this.activationElapsed = Duration.zero,
    this.activationError,
  });

  @override
  List<Object?> get props => [
    status,
    email,
    password,
    fullName,
    gender,
    isValid,
    isActivationInProgress,
    activationElapsed,
    activationError,
  ];

  UserState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    FullName? fullName,
    bool? gender,
    bool? isValid,
    bool? isActivationInProgress,
    int? activationAttempts,
    Duration? activationElapsed,
    String? activationError,
  }) {
    return UserState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      isValid: isValid ?? this.isValid,
      isActivationInProgress:
          isActivationInProgress ?? this.isActivationInProgress,
      activationElapsed: activationElapsed ?? this.activationElapsed,
      activationError: activationError ?? this.activationError,
    );
  }
}
