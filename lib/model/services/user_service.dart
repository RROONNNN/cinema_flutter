import 'package:cinema_flutter/shared/utils/http.dart';
import 'package:cinema_flutter/view_model/auth/user.dart';

class UserService {
  static UserService? _instance;
  UserService._internal();
  factory UserService() {
    _instance ??= UserService._internal();
    return _instance!;
  }
  Future<User> getProfile() async {
    final response = await dio.get('/users/profile');
    final userMap = response.data['data'] as Map<String, dynamic>;
    return User.fromMap(userMap);
  }
}
