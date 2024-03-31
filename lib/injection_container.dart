import 'package:get_it/get_it.dart';
import 'package:movies_app/core/managers/dio_manager.dart';
import 'package:movies_app/data/datasources/genres_remote_data_source.dart';
import 'package:movies_app/data/datasources/movies_remote_data_source.dart';
import 'package:movies_app/data/datasources/remote/genres_remote_data_source_impl.dart';
import 'package:movies_app/data/datasources/remote/movies_remote_data_sources_impl.dart';
import 'package:movies_app/data/repositories/genres_repository_impl.dart';
import 'package:movies_app/data/repositories/movies_repository_impl.dart';
import 'package:movies_app/domain/repositories/genre_repository.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';
import 'package:movies_app/domain/usecases/get_genres.dart';
import 'package:movies_app/domain/usecases/get_popular_movies.dart';
import 'package:movies_app/domain/usecases/get_trending_movies.dart';
import 'package:movies_app/domain/usecases/search_movie.dart';
import 'package:movies_app/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movies_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_bloc.dart';

final getIt = GetIt.instance;

void init() {
  // Bloc
  getIt.registerFactory(() => PopularMoviesBloc(getPopularMovies: getIt()));
  getIt.registerFactory(() => TrendingMoviesBloc(getTrendingMovies: getIt()));
  getIt.registerFactory(() => SearchMoviesBloc(searchMovies: getIt()));
  getIt.registerFactory(() => GenresBloc(getGenres: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMovies(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));
  getIt.registerLazySingleton(() => GetGenres(getIt()));

  // Repositories
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(remoteDataSource: getIt()));

  getIt.registerLazySingleton<GenreRepository>(
      () => GenreRepositoryImpl(remoteDataSource: getIt()));

  // Data sources
  getIt.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(dio: getIt()));

  getIt.registerLazySingleton<GenresRemoteDataSource>(
      () => GenresRemoteDataSourceImpl(dio: getIt()));

  // Dio service
  getIt.registerLazySingleton(() => DioManager.getDio());
}
