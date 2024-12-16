import 'package:dio/dio.dart';
import 'package:movies_app_challenge/core/error/failures.dart';
import 'package:movies_app_challenge/features/movies/data/datasource/genres_remote_data_source.dart';
import 'package:movies_app_challenge/features/movies/domain/entities/genre.dart';
import 'package:movies_app_challenge/features/movies/domain/repositories/genres_repository.dart';

class GenreRepositoryImpl implements GenresRepository {
  final GenresRemoteDataSource genresRemoteDataSource;

  GenreRepositoryImpl({required this.genresRemoteDataSource});

  @override
  Future<List<Genre>> getMovieGenres(String lang) async {
    try {
      final List<Genre> response =
          await genresRemoteDataSource.getMovieGenres(lang);
      return response;
    } on DioException {
      throw ServerFailure();
    }
  }
}
