import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<AdminMoviesLoadMore>(_onAdminMoviesLoadMore);
    on<AdminMoviesCacheImage>(_onAdminMoviesCacheImage);
    on<AdminMoviesCreateMovie>(_onAdminMoviesCreateMovie);
    on<AdminMoviesReset>(_onAdminMoviesReset);
    on<AdminMoviesArchiveMovie>(_onAdminMoviesArchiveMovie);
    on<AdminMoviesRestoreMovie>(_onAdminMoviesRestoreMovie);
    on<AdminMoviesInitBeforeUpdate>(_onAdminMoviesInitBeforeUpdate);
    on<AdminMoviesUpdateMovie>(_onAdminMoviesUpdateMovie);
    on<AdminMoviesCreateGenre>(_onAdminMoviesCreateGenre);
    on<AdminMoviesUpdateGenre>(_onAdminMoviesUpdateGenre);
    on<AdminMoviesArchiveGenre>(_onAdminMoviesArchiveGenre);
    on<AdminMoviesRestoreGenre>(_onAdminMoviesRestoreGenre);
    on<AdminMoviesSearchMovies>(_onAdminMoviesSearchMovies);
    on<AdminMoviesSearchGenres>(_onAdminMoviesSearchGenres);
    on<AdminMoviesLoadMoreGenres>(_onAdminMoviesLoadMoreGenres);
    on<AdminMoviesOnSearchChange>(_onAdminMoviesOnSearchChange);
  }

  Future<void> _onAdminMoviesOnSearchChange(
    AdminMoviesOnSearchChange event,
    Emitter<AdminMoviesState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.searchQuery));
  }

  Future<void> _onAdminMoviesSearchGenres(
    AdminMoviesSearchGenres event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final genres = await _movieService.getAllGenres(
        page: 1,
        limit: 10,
        search: state.searchQuery,
      );
      emit(
        state.copyWith(
          availableGenres: genres,
          isLoading: false,
          genresPage: 1,
          hasLoadMore: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to search genres",
        ),
      );
    }
  }

  Future<void> _onAdminMoviesLoadMoreGenres(
    AdminMoviesLoadMoreGenres event,
    Emitter<AdminMoviesState> emit,
  ) async {
    if (!state.hasLoadMore) {
      return;
    }
    try {
      final genres = await _movieService.getAllGenres(
        page: state.page + 1,
        limit: state.limit,
        search: state.searchQuery,
      );
      if (genres.isNotEmpty) {
        final hasLoadMore = genres.length == state.limit;
        final newPage = hasLoadMore ? state.genresPage + 1 : state.genresPage;
        emit(
          state.copyWith(
            availableGenres: [...state.availableGenres, ...genres],
            isLoading: false,
            genresPage: newPage,
            hasLoadMore: hasLoadMore,
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false, hasLoadMore: false));
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to load more genres",
        ),
      );
    }
  }

  Future<void> _onAdminMoviesSearchMovies(
    AdminMoviesSearchMovies event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final movies = await _movieService.getMovies(
        page: 1,
        limit: state.limit,
        search: state.searchQuery,
      );
      emit(
        state.copyWith(
          movies: movies,
          isLoading: false,
          page: 1,
          hasLoadMore: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to search movies",
        ),
      );
    }
  }

  Future<void> _onAdminMoviesCreateGenre(
    AdminMoviesCreateGenre event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await _movieService.createGenre(event.genreMap);
      emit(
        state.copyWith(
          status: AdminMoviesStatus.success,
          availableGenres: [response, ...state.availableGenres],
          successMessage: "Genre created successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to create genre",
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onAdminMoviesUpdateGenre(
    AdminMoviesUpdateGenre event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await _movieService.updateGenre(
        event.genreId,
        event.genreMap,
      );
      emit(
        state.copyWith(
          status: AdminMoviesStatus.success,
          availableGenres: state.availableGenres.map((genre) {
            if (genre.id == event.genreId) {
              return response;
            }
            return genre;
          }).toList(),
          successMessage: "Genre updated successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to update genre",
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onAdminMoviesUpdateMovie(
    AdminMoviesUpdateMovie event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await _movieService.updateMovie(
        event.movieId,
        event.movieMap,
      );
      // update the movie in the list
      final updatedMovies = state.movies.map((movie) {
        if (movie.id == event.movieId) {
          return response;
        }
        return movie;
      }).toList();
      emit(
        state.copyWith(
          status: AdminMoviesStatus.success,
          movies: updatedMovies,
          successMessage: "Movie updated successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to update movie",
        ),
      );
    }
  }

  Future<void> _onAdminMoviesInitBeforeUpdate(
    AdminMoviesInitBeforeUpdate event,
    Emitter<AdminMoviesState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedMovie: event.movie,
        selectedGenreIds: event.movie.genres.map((genre) => genre.id).toList(),
      ),
    );
  }

  Future<void> _onAdminMoviesArchiveMovie(
    AdminMoviesArchiveMovie event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      await _movieService.archiveMovie(event.movieId);

      final updatedMovies = state.movies.map((movie) {
        if (movie.id == event.movieId) {
          return movie.copyWith(isActive: false);
        }
        return movie;
      }).toList();
      emit(
        state.copyWith(
          status: AdminMoviesStatus.success,
          movies: updatedMovies,
          successMessage: "Movie archived successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to archive movie",
        ),
      );
      debugPrint(e.toString());
    }
  }

  Future<void> _onAdminMoviesRestoreMovie(
    AdminMoviesRestoreMovie event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      await _movieService.restoreMovie(event.movieId);
      final updatedMovies = state.movies.map((movie) {
        if (movie.id == event.movieId) {
          return movie.copyWith(isActive: true);
        }
        return movie;
      }).toList();
      emit(
        state.copyWith(
          status: AdminMoviesStatus.success,
          movies: updatedMovies,
          successMessage: "Movie restored successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to restore movie",
        ),
      );
      emit(
        state.copyWith(status: AdminMoviesStatus.loaded, errorMessage: null),
      );
    }
  }

  Future<void> _onAdminMoviesReset(
    AdminMoviesReset event,
    Emitter<AdminMoviesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AdminMoviesStatus.loaded,
        isLoading: false,
        selectedGenreIds: [],
        selectedMovie: null,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }

  Future<void> _onAdminMoviesCreateMovie(
    AdminMoviesCreateMovie event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final formData = event.movieMap;
      final response = await _movieService.createMovie(formData);
      emit(
        state.copyWith(
          status: AdminMoviesStatus.success,
          movies: [response, ...state.movies],
          successMessage: "Movie created successfully",
        ),
      );
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to create movie",
          isLoading: false,
        ),
      );

      debugPrint(e.toString());
    }
  }

  Future<void> _onAdminMoviesInitial(
    AdminMoviesInitial event,
    Emitter<AdminMoviesState> emit,
  ) async {
    bool isLoaded = false;
    if (state.status == AdminMoviesStatus.loaded) {
      isLoaded = true;
    }
    emit(state.copyWith(status: AdminMoviesStatus.loading));
    try {
      final movies = await _movieService.getMovies(page: 1, limit: 10);
      emit(state.copyWith(status: AdminMoviesStatus.loaded, movies: movies));
      final genres = await _movieService.getAllGenres();
      if (isLoaded) {
        emit(
          state.reInitialize(
            cachedThumbnails: state.cachedThumbnails,
            movies: movies,
            availableGenres: genres,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AdminMoviesStatus.loaded,
            availableGenres: genres,
            movies: movies,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: AdminMoviesStatus.error));
    }
  }

  Future<void> _onAdminMoviesLoadMore(
    AdminMoviesLoadMore event,
    Emitter<AdminMoviesState> emit,
  ) async {
    if (!state.hasLoadMore) {
      return;
    }
    try {
      final movies = await _movieService.getMovies(
        page: state.page + 1,
        limit: state.limit,
        search: state.searchQuery,
      );
      if (movies.isNotEmpty) {
        final hasLoadMore = movies.length == state.limit;
        final newPage = hasLoadMore ? state.page + 1 : state.page;
        emit(
          state.copyWith(
            status: AdminMoviesStatus.loaded,
            movies: [...state.movies, ...movies],
            page: newPage,
            hasLoadMore: hasLoadMore,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to load more movies",
        ),
      );
      debugPrint(e.toString());
    }
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

  Future<void> _onAdminMoviesArchiveGenre(
    AdminMoviesArchiveGenre event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      await _movieService.archiveGenre(event.genreId);
      final updatedGenres = state.availableGenres.map((genre) {
        if (genre.id == event.genreId) {
          return genre.copyWith(isActive: false);
        }
        return genre;
      }).toList();
      emit(
        state.copyWith(
          status: AdminMoviesStatus.success,
          availableGenres: updatedGenres,
          successMessage: "Genre archived successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to archive genre",
        ),
      );
    }
  }

  Future<void> _onAdminMoviesRestoreGenre(
    AdminMoviesRestoreGenre event,
    Emitter<AdminMoviesState> emit,
  ) async {
    try {
      await _movieService.restoreGenre(event.genreId);
      final updatedGenres = state.availableGenres.map((genre) {
        if (genre.id == event.genreId) {
          return genre.copyWith(isActive: true);
        }
        return genre;
      }).toList();
      emit(
        state.copyWith(
          status: AdminMoviesStatus.success,
          availableGenres: updatedGenres,
          successMessage: "Genre restored successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminMoviesStatus.error,
          errorMessage: "Failed to restore genre",
        ),
      );
    }
  }
}
