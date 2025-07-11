import 'package:formz/formz.dart';

enum PasswordValidationError { empty, tooShort, noCharOrNumber }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static final _hasLetter = RegExp(r'[A-Za-z]');
  static final _hasNumber = RegExp(r'\d');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length <= 10) return PasswordValidationError.tooShort;
    if (!_hasLetter.hasMatch(value) || !_hasNumber.hasMatch(value)) {
      return PasswordValidationError.noCharOrNumber;
    }
    return null;
  }
}
