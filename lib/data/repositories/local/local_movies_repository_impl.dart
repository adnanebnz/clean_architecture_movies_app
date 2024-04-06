import 'package:dartz/dartz.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/data/datasources/local/movies_local_data_source.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/local/local_movie_repository.dart';

class LocalMovieRepositoryImpl implements LocalMovieRepository {
  final MoviesLocalDataSource localDataSource;

  LocalMovieRepositoryImpl({required this.localDataSource});

  @override
  FutureEither<void> addFavMovie(Movie movie) async {
    try {
      await localDataSource.addFavMovie(movie.toModel());
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  FutureEither<void> addWatchMovie(Movie movie) async {
    try {
      await localDataSource.addWatchMovie(movie.toModel());
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  FutureEither<List<Movie>> getFavMovies() async {
    try {
      List<MovieModel> moviesModels = await localDataSource.getFavMovies();
      List<Movie> movies = moviesModels.map((e) => e.toEntity()).toList();
      return Right(movies);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  FutureEither<List<Movie>> getToWatchMovies() async {
    try {
      List<MovieModel> moviesModels = await localDataSource.getToWatchMovies();
      List<Movie> movies = moviesModels.map((e) => e.toEntity()).toList();
      return Right(movies);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  FutureEither<void> removeFavMovie(Movie movie) async {
    try {
      await localDataSource.removeFavMovie(movie.toModel());
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  FutureEither<void> removeWatchMovie(Movie movie) async {
    try {
      await localDataSource.removeWatchMovie(movie.toModel());
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  FutureEither<List<Movie>> searchFavMovies(String query) async {
    try {
      List<MovieModel> moviesModels =
          await localDataSource.searchFavMovies(query);
      List<Movie> movies = moviesModels.map((e) => e.toEntity()).toList();
      return Right(movies);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
