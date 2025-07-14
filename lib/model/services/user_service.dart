import 'package:cinema_flutter/shared/utils/dio_config.dart';
import 'package:cinema_flutter/view_model/auth/user.dart';
import 'package:dio/dio.dart';

class UserService {
  static UserService? _instance;
  late final Dio dio;
  UserService._internal() {
    dio = DioConfig().authDio;
  }
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
