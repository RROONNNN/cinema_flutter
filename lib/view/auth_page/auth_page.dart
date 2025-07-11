import 'package:cinema_flutter/model/repositories/auth_repository.dart';
import 'package:cinema_flutter/shared/extensions/custom_theme_extension.dart';
import 'package:cinema_flutter/view/auth_page/cubit/user_cubit.dart';
import 'package:cinema_flutter/view_model/auth/email.dart';
import 'package:cinema_flutter/view_model/auth/full_name.dart';
import 'package:cinema_flutter/view_model/auth/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';
import 'package:cinema_flutter/shared/widgets/text/custom_text_style.dart';

class AuthPage extends StatefulWidget {
  final bool isLogin;
  const AuthPage({super.key, this.isLogin = true});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.bg,
      appBar: AppBar(
        backgroundColor: theme.bg,
        elevation: 0,
        centerTitle: true,
        title: TitleText(
          widget.isLogin ? 'Login' : 'Sign Up',
          color: theme.textColor,
        ),
        iconTheme: IconThemeData(color: theme.textColor),
      ),
      body: BlocProvider(
        create: (context) =>
            UserCubit(authenticationRepository: AuthRepository.instance),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/background_auth.jpg', fit: BoxFit.cover),

            Container(color: Colors.black.withOpacity(0.65)),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.appBar.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: widget.isLogin
                      ? const LoginForm()
                      : const SignUpForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.watch<UserCubit>().state.status ==
              FormzSubmissionStatus.failure)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                color: theme.red.withOpacity(0.15),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: theme.red, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Authentication Failure. Please check your credentials.',
                          style: TextStyle(
                            color: theme.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const TitleText('Welcome Back!', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          const _EmailInput(),
          const SizedBox(height: 16),
          const _PasswordInput(),
          const SizedBox(height: 24),
          const _SubmitButton(isLogin: true),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        final hasError = !state.email.isPure && state.email.error != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<UserCubit>().onEmailChanged(email),
              style: TextStyle(color: theme.textColor),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: theme.textColor.withOpacity(0.7)),
                filled: true,
                fillColor: theme.bg.withOpacity(0.7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: hasError ? theme.red : theme.grey,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: hasError ? theme.red : theme.blue,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.red, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.red, width: 2.5),
                ),
                suffixIcon: hasError
                    ? Icon(Icons.error_outline, color: theme.red)
                    : Icon(
                        Icons.email,
                        color: theme.textColor.withOpacity(0.7),
                      ),
                errorText: null, // We'll show error below
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  state.email.error == EmailValidationError.invalid
                      ? 'Invalid email'
                      : '',
                  style: TextStyle(
                    color: theme.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.watch<UserCubit>().state.status ==
              FormzSubmissionStatus.failure)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                color: theme.red.withOpacity(0.15),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: theme.red, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Sign Up Failure. Please check your input and try again.',
                          style: TextStyle(
                            color: theme.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const TitleText('Create Account', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          const _EmailInput(),
          const SizedBox(height: 16),
          const _PasswordInput(),
          const SizedBox(height: 16),
          const _FullNameInput(),
          const SizedBox(height: 16),
          const _GenderInput(),
          const SizedBox(height: 24),
          const _SubmitButton(isLogin: false),
        ],
      ),
    );
  }
}

class _FullNameInput extends StatelessWidget {
  const _FullNameInput();
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        final hasError = !state.fullName.isPure && state.fullName.error != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('loginForm_fullNameInput_textField'),
              onChanged: (fullName) =>
                  context.read<UserCubit>().onFullNameChanged(fullName),
              style: TextStyle(color: theme.textColor),
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(color: theme.textColor.withOpacity(0.7)),
                filled: true,
                fillColor: theme.bg.withOpacity(0.7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: hasError ? theme.red : theme.grey,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: hasError ? theme.red : theme.blue,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.red, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.red, width: 2.5),
                ),
                suffixIcon: hasError
                    ? Icon(Icons.error_outline, color: theme.red)
                    : Icon(
                        Icons.person_outline,
                        color: theme.textColor.withOpacity(0.7),
                      ),
                errorText: null, // We'll show error below
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  state.fullName.error == FullNameValidationError.empty
                      ? 'Full Name cannot be empty'
                      : '',
                  style: TextStyle(
                    color: theme.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _GenderInput extends StatelessWidget {
  const _GenderInput();
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: ContentText(
                'Gender: ${state.gender ? 'Male' : 'Female'}',
                color: theme.textColor,
              ),
            ),
            Switch(
              value: state.gender,
              onChanged: (gender) =>
                  context.read<UserCubit>().onGenderChanged(gender),
              activeThumbColor: theme.white,
              inactiveThumbColor: theme.grey,
              inactiveTrackColor: theme.grey.withOpacity(0.5),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        final hasError = !state.password.isPure && state.password.error != null;
        String? errorMsg;
        if (!state.password.isPure) {
          if (state.password.error == PasswordValidationError.empty) {
            errorMsg = 'Password cannot be empty';
          } else if (state.password.error == PasswordValidationError.tooShort) {
            errorMsg = 'Password must be longer than 10 characters';
          } else if (state.password.error ==
              PasswordValidationError.noCharOrNumber) {
            errorMsg = 'Password must contain both letters and numbers';
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<UserCubit>().onPasswordChanged(password),
              obscureText: true,
              style: TextStyle(color: theme.textColor),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: theme.textColor.withOpacity(0.7)),
                filled: true,
                fillColor: theme.bg.withOpacity(0.7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: hasError ? theme.red : theme.grey,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: hasError ? theme.red : theme.blue,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.red, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.red, width: 2.5),
                ),
                suffixIcon: hasError
                    ? Icon(Icons.error_outline, color: theme.red)
                    : Icon(
                        Icons.lock_outline,
                        color: theme.textColor.withOpacity(0.7),
                      ),
                errorText: null, // We'll show error below
              ),
            ),
            if (hasError && errorMsg != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  errorMsg,
                  style: TextStyle(
                    color: theme.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final bool isLogin;
  const _SubmitButton({required this.isLogin});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.97;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        if (state.status == FormzSubmissionStatus.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 80),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.white, theme.white.withOpacity(0.85)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: theme.white.withOpacity(0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: state.isValid
                        ? () => widget.isLogin
                              ? context.read<UserCubit>().onLoginSubmit()
                              : context.read<UserCubit>().onSignUpSubmit()
                        : null,
                    child: Center(
                      child: Text(
                        widget.isLogin ? 'Login' : 'Sign Up',
                        style: TextStyle(
                          color: theme.bg,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
