import 'package:bloc/bloc.dart';
import 'package:cinema_flutter/model/data_models/genres.dart';
import 'package:cinema_flutter/model/data_models/movie.dart';
import 'package:cinema_flutter/model/services/movie_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'admin_movies_event.dart';
part 'admin_movies_state.dart';

class AdminMoviesBloc extends Bloc<AdminMoviesEvent, AdminMoviesState> {
  late final MovieService _movieService;
  AdminMoviesBloc() : super(AdminMoviesState()) {
    _movieService = MovieService();
    on<AdminMoviesInitial>(_onAdminMoviesInitial);
    on<AdiminMoviesLoadMore>(_onAdminMoviesLoadMore);
    on<AdminMoviesCacheImage>(_onAdminMoviesCacheImage);
    on<AdminMoviesCreateMovie>(_onAdminMoviesCreateMovie);
  }
  Future<void> _onAdminMoviesCreateMovie(
    AdminMoviesCreateMovie event,
    Emitter<AdminMoviesState> emit,
  ) async {
    emit(state.copyWith(status: AdminMoviesStatus.loading));
    try {} catch (e) {}
  }

  Future<void> _onAdminMoviesInitial(
    AdminMoviesInitial event,
    Emitter<AdminMoviesState> emit,
  ) async {
    emit(state.copyWith(status: AdminMoviesStatus.loading));
    try {
      final movies = await _movieService.getMovies(page: 1, limit: 10);
      emit(state.copyWith(status: AdminMoviesStatus.loaded, movies: movies));
      final genres = await _movieService.getAllGenres();
      emit(
        state.copyWith(
          status: AdminMoviesStatus.loaded,
          availableGenres: genres,
          movies: movies,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AdminMoviesStatus.error));
    }
  }

  Future<void> _onAdminMoviesLoadMore(
    AdiminMoviesLoadMore event,
    Emitter<AdminMoviesState> emit,
  ) async {
    emit(state.copyWith(status: AdminMoviesStatus.loading));
    final movies = await _movieService.getMovies(
      page: state.page + 1,
      limit: state.limit,
    );
    emit(
      state.copyWith(
        status: AdminMoviesStatus.loaded,
        movies: [...state.movies, ...movies],
      ),
    );
  }

  Future<void> _onAdminMoviesCacheImage(
    AdminMoviesCacheImage event,
    Emitter<AdminMoviesState> emit,
  ) async {
    emit(
      state.copyWith(
        cachedThumbnails: {
          ...state.cachedThumbnails,
          event.movieId: event.thumbnail,
        },
      ),
    );
  }
}
