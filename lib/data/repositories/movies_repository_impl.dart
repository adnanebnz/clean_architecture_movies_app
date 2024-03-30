import 'package:dartz/dartz.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/data/datasources/movies_remote_data_source.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MoviesRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  FutureEither<List<Movie>> getPopularMovies() async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.getPopularMovies();
      final List<Movie> movies =
          movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    } on Failure catch (failure) {
      return Left(Failure(message: failure.message));
    }
  }

  @override
  FutureEither<List<Movie>> getTrendingMovies() async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.getTrendingMovies();
      final List<Movie> movies =
          movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    } on Failure catch (failure) {
      return Left(Failure(message: failure.message));
    }
  }

  @override
  FutureEither<List<Movie>> searchMovies(String query) async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.searchMovies(query);
      final List<Movie> movies =
          movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    } on Failure catch (failure) {
      return Left(Failure(message: failure.message));
    }
  }
}
