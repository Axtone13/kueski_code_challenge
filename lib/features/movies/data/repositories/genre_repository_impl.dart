import 'package:dio/dio.dart';
import 'package:movies_app_challenge/core/error/failures.dart';
import 'package:movies_app_challenge/features/movies/data/datasource/genres_remote_data_source.dart';
import 'package:movies_app_challenge/features/movies/domain/entities/genre.dart';
import 'package:movies_app_challenge/features/movies/domain/repositories/genres_repository.dart';

class GenreRepositoryImpl implements GenresRepository {
  final GenresRemoteDataSource genresRemoteDataSource;

  GenreRepositoryImpl({required this.genresRemoteDataSource});

  /**
   * Get movie genres from the API
   * 
   * @param lang The language to get the genres
   * 
   * @return List of genres
   * 
   * @throws ConnectionFailure When there is a connection error
   * 
   * @throws NotFoundFailure When the resource is not found
   * 
   * @throws UnauthorizedFailure When the request is unauthorized
   * 
   * @throws ServerFailure When there is a server error
   * 
   * @throws UnknownFailure When the error is unknown
   */
  @override
  Future<List<Genre>> getMovieGenres(String lang) async {
    try {
      final List<Genre> response =
          await genresRemoteDataSource.getMovieGenres(lang);
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw ConnectionFailure('Connection timeout');
      } else if (e.response?.statusCode == 404) {
        throw NotFoundFailure('Resource not found');
      } else if (e.response?.statusCode == 401) {
        throw UnauthorizedFailure('Unauthorized');
      } else {
        throw ServerFailure('Server error: ${e.message}');
      }
    } catch (e) {
      throw UnknownFailure('Unknown error: ${e.toString()}');
    }
  }
}
