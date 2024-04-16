import 'package:dio/dio.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/core/exceptions/dio_exception.dart';
import 'package:movies_app/core/managers/dio_manager.dart';
import 'package:movies_app/data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_app/data/models/movie_model.dart';

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  var dio = DioManager.getDio();

  MoviesRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    try {
      final response = await dio.get("/movie/popular", queryParameters: {
        "page": page,
      });
      final List<MovieModel> movies = (response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();

      return movies;
    } on DioException catch (dioError) {
      final error = DioExceptions.fromDioError(dioError);
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies(int page) async {
    try {
      final response = await dio.get("/trending/movie/day", queryParameters: {
        "page": page,
      });
      final List<MovieModel> movies = (response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
      return movies;
    } on DioException catch (dioError) {
      final error = DioExceptions.fromDioError(dioError);
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query, int page) async {
    try {
      final response = await dio.get("/search/movie", queryParameters: {
        "query": query,
        "page": page,
      });
      final List<MovieModel> movies = (response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
      return movies;
    } on DioException catch (dioError) {
      final error = DioExceptions.fromDioError(dioError);
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<List<MovieModel>> discoverMovies(int page) async {
    try {
      final response = await dio.get("/discover/movie", queryParameters: {
        "page": page,
      });
      final List<MovieModel> movies = (response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
      return movies;
    } on DioException catch (dioError) {
      final error = DioExceptions.fromDioError(dioError);
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
