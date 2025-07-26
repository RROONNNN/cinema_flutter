import 'package:cinema_flutter/model/data_models/cinema.dart';
import 'package:cinema_flutter/model/data_models/room.dart';
import 'package:cinema_flutter/shared/utils/dio_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CinemaService {
  static CinemaService? _instance;
  late final Dio dio;

  CinemaService._internal() {
    dio = DioConfig().cinemaDio;
  }

  factory CinemaService() {
    _instance ??= CinemaService._internal();
    return _instance!;
  }

  Future<List<Cinema>> getCinemas({
    int? page,
    int limit = 10,
    String? search,
  }) async {
    try {
      final response = await dio.get(
        '/cinemas',
        queryParameters: {'page': page, 'limit': limit, 'search': search},
      );
      final List<dynamic> cinemasData = response.data['data'] as List<dynamic>;
      return cinemasData.map((json) => Cinema.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch cinemas: $e');
    }
  }

  Future<Cinema> getCinemaById(String id) async {
    try {
      final response = await dio.get('/cinemas/$id');
      final cinemaData = response.data['data'] as Map<String, dynamic>;
      return Cinema.fromJson(cinemaData);
    } catch (e) {
      throw Exception('Failed to fetch cinema: $e');
    }
  }

  Future<Cinema> createCinema(Map<String, dynamic> cinemaData) async {
    try {
      final response = await dio.post('/cinemas', data: cinemaData);
      final createdCinemaData = response.data['data'] as Map<String, dynamic>;
      return Cinema.fromJson(createdCinemaData);
    } catch (e) {
      throw Exception('Failed to create cinema: $e');
    }
  }

  Future<Cinema> updateCinema(
    String id,
    Map<String, dynamic> cinemaData,
  ) async {
    try {
      final response = await dio.put('/cinemas/$id', data: cinemaData);
      final updatedCinemaData = response.data['data'] as Map<String, dynamic>;
      return Cinema.fromJson(updatedCinemaData);
    } catch (e) {
      throw Exception('Failed to update cinema: $e');
    }
  }

  Future<void> archiveCinema(String id) async {
    try {
      await dio.put('/cinemas/$id/archive');
    } catch (e) {
      throw Exception('Failed to archive cinema: $e');
    }
  }

  Future<void> restoreCinema(String id) async {
    try {
      await dio.put('/cinemas/$id/restore');
    } catch (e) {
      throw Exception('Failed to restore cinema: $e');
    }
  }

  Future<Room> createRoom(Map<String, dynamic> roomData) async {
    try {
      final response = await dio.post('/rooms', data: roomData);
      final createdRoomData = response.data['data'] as Map<String, dynamic>;
      return Room.fromJson(createdRoomData);
    } catch (e) {
      throw Exception('Failed to create room: $e');
    }
  }

  Future<Room> getRoomById(String id) async {
    try {
      final response = await dio.get('/rooms/$id');
      final roomData = response.data['data'] as Map<String, dynamic>;
      return Room.fromJson(roomData);
    } catch (e) {
      throw Exception('Failed to get room: $e');
    }
  }
}
