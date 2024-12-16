import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_challenge/features/movies/domain/use_cases/get_movie_genres.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/genres/genres_state.dart';

import 'genres_event.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GetGenresUseCase getGenres;

  GenresBloc(this.getGenres) : super(GenreInitial()) {
    /* When the LoadGenres event is dispatched, the GenresBloc will call the
    getGenres use case to get the genres and emit the GenreListLoaded state. 
    If an error occurs, the GenreError state will be emitted. */
    on<LoadGenres>((event, emit) async {
      emit(GenreLoading());
      try {
        final genres = await getGenres.call(event.lang);
        emit(GenreListLoaded(genres));
      }  catch (e) {
        debugPrint(e.toString());
        emit(GenreError('Failed to load genres'));
      }
    });
  }
}
