import 'package:cinema_flutter/shared/utils/dio_config.dart';
import 'package:cinema_flutter/model/data_models/movie.dart';
import 'package:cinema_flutter/model/data_models/genres.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class MovieService {
  static MovieService? _instance;
  late final Dio dio;

  MovieService._internal() {
    dio = DioConfig().movieDio;
  }

  factory MovieService() {
    _instance ??= MovieService._internal();
    return _instance!;
  }

  // Get all movies
  Future<List<Movie>> getMovies({
    int? page,
    int limit = 10,
    int? rating,
    String? search,
    List<String>? genreQuery,
  }) async {
    try {
      final response = await dio.get(
        '/movies/public',
        queryParameters: {
          'page': page,
          'limit': limit,
          'rating': rating,
          'search': search,
          'genreQuery': genreQuery?.join(','),
        },
      );
      final List<dynamic> moviesData = response.data['data'] as List<dynamic>;
      return moviesData.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch movies: $e');
    }
  }

  // Get movie by ID
  Future<Movie> getMovieById(String id) async {
    try {
      final response = await dio.get('/movies/public/$id');
      final movieData = response.data['data'] as Map<String, dynamic>;
      return Movie.fromJson(movieData);
    } catch (e) {
      throw Exception('Failed to fetch movie: $e');
    }
  }

  // Create new movie
  Future<Movie> createMovie(Map<String, dynamic> movieData) async {
    try {
      FormData formData = FormData.fromMap(movieData);
      final response = await dio.post('/movies', data: formData);
      final responseData = response.data['data'] as Map<String, dynamic>;
      return Movie.fromJson(responseData);
    } catch (e) {
      throw Exception('Failed to create movie: $e');
    }
  }

  // Update movie
  Future<Movie> updateMovie(String id, Map<String, dynamic> movieData) async {
    try {
      final response = await dio.put('/movies/$id', data: movieData);
      final responseData = response.data['data'] as Map<String, dynamic>;
      return Movie.fromJson(responseData);
    } catch (e) {
      throw Exception('Failed to update movie: $e');
    }
  }

  // Get all genres
  Future<List<Genres>> getAllGenres({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (search != null && search.isNotEmpty) 'search': search,
      };

      final response = await dio.get(
        '/genres/public',
        queryParameters: queryParameters,
      );
      final List<dynamic> genresData = response.data['data'] as List<dynamic>;
      return genresData.map((json) => Genres.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch genres: $e');
    }
  }

  Future<void> archiveMovie(String id) async {
    try {
      await dio.put('/movies/archive/$id');
    } catch (e) {
      throw Exception('Failed to archive movie: $e');
    }
  }

  Future<void> restoreMovie(String id) async {
    try {
      await dio.put('/movies/restore/$id');
    } catch (e) {
      throw Exception('Failed to restore movie: $e');
    }
  }

  Future<Genres> createGenre(Map<String, dynamic> genreData) async {
    try {
      final response = await dio.post('/genres', data: genreData);
      final responseData = response.data['data'] as Map<String, dynamic>;
      return Genres.fromJson(responseData);
    } catch (e) {
      throw Exception('Failed to create genre: $e');
    }
  }

  Future<Genres> updateGenre(String id, Map<String, dynamic> genreData) async {
    try {
      final response = await dio.put('/genres/$id', data: genreData);
      final responseData = response.data['data'] as Map<String, dynamic>;
      return Genres.fromJson(responseData);
    } catch (e) {
      throw Exception('Failed to update genre: $e');
    }
  }

  Future<void> archiveGenre(String id) async {
    try {
      await dio.put('/genres/archive/$id');
    } catch (e) {
      throw Exception('Failed to archive genre: $e');
    }
  }

  Future<void> restoreGenre(String id) async {
    try {
      await dio.put('/genres/restore/$id');
    } catch (e) {
      throw Exception('Failed to restore genre: $e');
    }
  }

  Future<void> testCreateMovie() async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? thumbnailFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      XFile? trailerFile = await picker.pickVideo(source: ImageSource.gallery);
      if (thumbnailFile == null && trailerFile == null) {
        throw Exception('No file selected');
      }
      await createMovie({
        'title': 'abfsd',
        'description': 'asaasdsdasd',
        'duration': 123,
        'releaseDate': '2025-07-13',
        'genresIds': 'ac777b63-ae39-4ace-9bbf-0f78f2c2f0c9',
        'thumbnail': await MultipartFile.fromFile(
          thumbnailFile!.path,
          filename: 'thumbnail.jpg',
        ),
        'trailer': await MultipartFile.fromFile(
          trailerFile!.path,
          filename: 'trailer.mp4',
        ),
      });
      //     final response = await dio.post('/movies', data: formData);
      // final responseData = response.data['data'] as Map<String, dynamic>;
      // return Movie.fromJson(responseData);
    } catch (e) {
      throw Exception('Failed to create test movie: $e');
    }
  }
}
