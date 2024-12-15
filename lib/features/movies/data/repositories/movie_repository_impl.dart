import 'package:dio/dio.dart';
import 'package:kueski_code_challenge/core/error/failures.dart';
import 'package:kueski_code_challenge/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:kueski_code_challenge/features/movies/domain/entities/movie.dart';
import 'package:kueski_code_challenge/features/movies/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource moviesRemoteDataSource;

  MovieRepositoryImpl({required this.moviesRemoteDataSource});

  @override
  Future<List<Movie>> getPopularMovies(String lang, int page) async {
    try {
      final List<Movie> response =
          await moviesRemoteDataSource.getPopularMovies(lang, page);
      return response;
    } on DioException {
      throw ServerFailure();
    }
  }
}
