import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String password;
  final String fullname;
  final String gender;
  final String role;
  final String avatarUrl;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.fullname,
    required this.gender,
    required this.role,
    required this.avatarUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    final id = map['id'];
    if (id == null) {
      throw Exception('User ID is null');
    }
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      fullname: map['fullname'] ?? '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
      avatarUrl: map['avatarUrl'] ?? map['photoUrl'] ?? '',
      isActive: map['isActive'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ??
                DateTime.fromMillisecondsSinceEpoch(0)
          : DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt']) ??
                DateTime.fromMillisecondsSinceEpoch(0)
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'fullname': fullname,
      'gender': gender,
      'role': role,
      'avatarUrl': avatarUrl,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    email,
    password,
    fullname,
    gender,
    role,
    avatarUrl,
    isActive,
    createdAt,
    updatedAt,
  ];

  static const empty = User(
    id: '',
    email: '',
    password: '',
    fullname: '',
    gender: '',
    role: '',
    avatarUrl: '',
    isActive: false,
    createdAt: null,
    updatedAt: null,
  );
}
