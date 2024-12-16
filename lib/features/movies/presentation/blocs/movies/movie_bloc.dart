import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_challenge/features/movies/domain/entities/movie.dart';
import 'package:movies_app_challenge/features/movies/domain/use_cases/get_popular_movies.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMoviesUseCase getMovies;

  MovieBloc(this.getMovies) : super(MovieInitial()) {
    on<LoadMovies>((event, emit) async {
      if (state is MovieLoading) return;
      final currentState = state;
      var oldMovies = <Movie>[];
      if (currentState is MovieListLoaded && event.page > 1) {
        oldMovies = currentState.movies;
      }

      emit(MovieLoading(oldMovies));

      try {
        final movies = await getMovies.call(event.lang, event.page);
        emit(MovieListLoaded(oldMovies + movies));
      } catch (e) {
        debugPrint(e.toString());
        emit(MovieError('Failed to load movies'));
      }
    });
  }
}
