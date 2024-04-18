import 'package:dio/dio.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/core/exceptions/dio_exception.dart';
import 'package:movies_app/core/managers/dio_manager.dart';
import 'package:movies_app/core/utils/filter_params.dart';
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
  Future<List<MovieModel>> discoverMovies(
      int page, FilterParams filterParams) async {
    try {
      final Map<String, dynamic> queryParameters = {
        'page': page,
        if (filterParams.sortBy != null) 'sort_by': filterParams.sortBy,
        if (filterParams.voteAverageGte != null)
          'vote_average.gte': filterParams.voteAverageGte.toString(),
        if (filterParams.voteCountGte != null)
          'vote_count.gte': filterParams.voteCountGte.toString(),
        if (filterParams.release_date_gte != null)
          'release_date.gte': filterParams.release_date_gte.toString(),
        if (filterParams.release_date_lte != null)
          'release_date.lte': filterParams.release_date_lte.toString(),
        if (filterParams.vote_average_lte != null)
          'vote_average.lte': filterParams.vote_average_lte.toString(),
        if (filterParams.vote_average_gte != null)
          'vote_average.gte': filterParams.vote_average_gte.toString(),
        if (filterParams.vote_count_lte != null)
          'vote_count.lte': filterParams.vote_count_lte.toString(),
        if (filterParams.vote_count_gte != null)
          'vote_count.gte': filterParams.vote_count_gte.toString(),
        if (filterParams.with_genres != null)
          'with_genres': filterParams.with_genres!.join(','),
        if (filterParams.year != null) 'year': filterParams.year.toString(),
      };

      final response = await dio.get("/discover/movie", queryParameters: {
        "page": page,
        ...queryParameters,
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
