import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/core/managers/dio_manager.dart';
import 'package:movies_app/core/managers/hive_manager.dart';
import 'package:movies_app/data/datasources/local/movies_local_data_source.dart';
import 'package:movies_app/data/datasources/local/movies_local_data_source_impl.dart';
import 'package:movies_app/data/datasources/remote/genres_remote_data_source.dart';
import 'package:movies_app/data/datasources/remote/genres_remote_data_source_impl.dart';
import 'package:movies_app/data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_app/data/datasources/remote/movies_remote_data_sources_impl.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/data/repositories/local/local_movies_repository_impl.dart';
import 'package:movies_app/data/repositories/remote/genres_repository_impl.dart';
import 'package:movies_app/data/repositories/remote/movies_repository_impl.dart';
import 'package:movies_app/domain/repositories/local/local_movie_repository.dart';
import 'package:movies_app/domain/repositories/remote/genre_repository.dart';
import 'package:movies_app/domain/repositories/remote/movie_repository.dart';
import 'package:movies_app/domain/usecases/local/add_fav_movie.dart';
import 'package:movies_app/domain/usecases/local/add_to_watch_movie.dart';
import 'package:movies_app/domain/usecases/local/get_fav_movies.dart';
import 'package:movies_app/domain/usecases/local/get_to_watch_movies.dart';
import 'package:movies_app/domain/usecases/local/remove_fav_movie.dart';
import 'package:movies_app/domain/usecases/local/remove_to_watch_movie.dart';
import 'package:movies_app/domain/usecases/local/search_fav_movies.dart';
import 'package:movies_app/domain/usecases/remote/get_genres.dart';
import 'package:movies_app/domain/usecases/remote/get_popular_movies.dart';
import 'package:movies_app/domain/usecases/remote/get_trending_movies.dart';
import 'package:movies_app/domain/usecases/remote/search_movie.dart';
import 'package:movies_app/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movies_app/presentation/bloc/local_fav_movies/local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movie_trailer/movie_trailer_bloc.dart';
import 'package:movies_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_bloc.dart';

final getIt = GetIt.instance;

void init() async {
  // Bloc
  getIt.registerFactory(() => PopularMoviesBloc(getPopularMovies: getIt()));
  getIt.registerFactory(() => TrendingMoviesBloc(getTrendingMovies: getIt()));
  getIt.registerFactory(() => SearchMoviesBloc(searchMovies: getIt()));
  getIt.registerFactory(() => GenresBloc(getGenres: getIt()));
  getIt.registerFactory(() => MovieTrailerBloc());
  getIt.registerFactory(
    () => LocalFavMoviesBloc(
      getFavMovies: getIt(),
      removeFavMovie: getIt(),
      searchFavMovies: getIt(),
      addFavMovie: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMovies(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));
  getIt.registerLazySingleton(() => GetGenres(getIt()));
  getIt.registerLazySingleton(() => AddFavMovie(getIt()));
  getIt.registerLazySingleton(() => AddToWatchMovie(getIt()));
  getIt.registerLazySingleton(() => RemoveFavMovie(getIt()));
  getIt.registerLazySingleton(() => RemoveToWatchMovie(getIt()));
  getIt.registerLazySingleton(() => GetToWatchMovies(getIt()));
  getIt.registerLazySingleton(() => GetFavMovies(getIt()));
  getIt.registerLazySingleton(() => SearchFavMovies(getIt()));
  // Repositories
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(remoteDataSource: getIt()));

  getIt.registerLazySingleton<GenreRepository>(
      () => GenreRepositoryImpl(remoteDataSource: getIt()));

  getIt.registerLazySingleton<LocalMovieRepository>(
      () => LocalMovieRepositoryImpl(localDataSource: getIt()));

  // Data sources
  getIt.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(dio: getIt()));

  getIt.registerLazySingleton<GenresRemoteDataSource>(
      () => GenresRemoteDataSourceImpl(dio: getIt()));

  getIt.registerLazySingleton<MoviesLocalDataSource>(
      () => MovieslocalDataSourceImpl(box: getIt()));

  // Dio service
  getIt.registerLazySingleton(() => DioManager.getDio());
  // GetStorage service
  // getIt.registerLazySingleton(() => GetStorageManager.getStorage());
  // Hive Boxes
  final moviesBox = await HiveManager.getMoviesBox();
  getIt.registerLazySingleton<Box<MovieModel>>(() => moviesBox);
}
