import 'package:cinema_flutter/model/data_models/showtime.dart';
import 'package:cinema_flutter/shared/utils/dio_config.dart';
import 'package:dio/dio.dart';

class ShowtimeService {
  static ShowtimeService? _instance;
  late final Dio dio;

  ShowtimeService._internal() {
    dio = DioConfig().showtimeDio;
  }

  factory ShowtimeService() {
    _instance ??= ShowtimeService._internal();
    return _instance!;
  }

  Future<List<Showtime>> getShowtimes({
    int? page,
    int limit = 10,
    String? search,
    String? cinemaId,
    String? movieId,
  }) async {
    try {
      final response = await dio.get(
        '/showtimes/public',
        queryParameters: {
          'page': page,
          'limit': limit,
          'search': search,
          'cinemaId': cinemaId,
          'movieId': movieId,
        },
      );
      final List<dynamic> showtimesData =
          response.data['data'] as List<dynamic>;
      return showtimesData.map((json) => Showtime.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch showtimes: $e');
    }
  }

  Future<Showtime> getShowtimeById(String id) async {
    try {
      final response = await dio.get('/showtimes/public/$id');
      final showtimeData = response.data['data'] as Map<String, dynamic>;
      return Showtime.fromJson(showtimeData);
    } catch (e) {
      throw Exception('Failed to fetch showtime: $e');
    }
  }

  Future<Showtime> createShowtime(Map<String, dynamic> showtimeData) async {
    try {
      final response = await dio.post('/showtimes', data: showtimeData);
      final createdShowtimeData = response.data['data'] as Map<String, dynamic>;
      return Showtime.fromJson(createdShowtimeData);
    } catch (e) {
      throw Exception('Failed to create showtime: $e');
    }
  }

  Future<Showtime> updateShowtime(
    String id,
    Map<String, dynamic> showtimeData,
  ) async {
    try {
      final response = await dio.put('/showtimes/$id', data: showtimeData);
      final updatedShowtimeData = response.data['data'] as Map<String, dynamic>;
      return Showtime.fromJson(updatedShowtimeData);
    } catch (e) {
      throw Exception('Failed to update showtime: $e');
    }
  }

  Future<void> archiveShowtime(String id) async {
    try {
      await dio.put('/showtimes/archive/$id');
    } catch (e) {
      throw Exception('Failed to archive showtime: $e');
    }
  }

  Future<void> restoreShowtime(String id) async {
    try {
      await dio.put('/showtimes/restore/$id');
    } catch (e) {
      throw Exception('Failed to restore showtime: $e');
    }
  }
}
