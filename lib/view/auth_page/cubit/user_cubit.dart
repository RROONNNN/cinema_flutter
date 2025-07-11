import 'package:bloc/bloc.dart';
import 'package:cinema_flutter/model/repositories/auth_repository.dart';
import 'package:cinema_flutter/view_model/auth/email.dart';
import 'package:cinema_flutter/view_model/auth/full_name.dart';
import 'package:cinema_flutter/view_model/auth/password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AuthRepository _authenticationRepository;
  UserCubit({required AuthRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository,
      super(const UserState());

  void onEmailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password, email]),
      ),
    );
  }

  void onPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  void onFullNameChanged(String value) {
    final fullName = FullName.dirty(value);
    emit(
      state.copyWith(
        fullName: fullName,
        isValid: Formz.validate([state.email, state.password, fullName]),
      ),
    );
  }

  void onGenderChanged(bool value) {
    emit(
      state.copyWith(
        gender: value,
        isValid: Formz.validate([state.email, state.password, state.fullName]),
      ),
    );
  }

  Future<void> onLoginSubmit() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.logIn(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  Future<void> onSignUpSubmit() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signUpWithActivation(
          email: state.email.value,
          password: state.password.value,
          fullName: state.fullName.value,
          gender: state.gender,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
