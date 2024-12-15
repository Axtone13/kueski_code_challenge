import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kueski_code_challenge/features/movies/domain/use_cases/get_popular_movies.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMoviesUseCase getMovies;

  MovieBloc(this.getMovies) : super(MovieInitial()) {
    on<LoadMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await getMovies.call(event.lang, event.page);
        emit(MovieListLoaded(movies));
      } catch (e) {
        debugPrint(e.toString());
        emit(MovieError('Failed to load movies'));
      }
    });
  }
}
