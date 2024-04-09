part of 'local_fav_movies_bloc.dart';

sealed class LocalFavMoviesState extends Equatable {
  const LocalFavMoviesState();

  @override
  List<Object> get props => [];
}

final class LocalFavMoviesInitial extends LocalFavMoviesState {}

final class LocalFavMoviesLoading extends LocalFavMoviesState {}

final class LocalFavMoviesLoaded extends LocalFavMoviesState {
  final List<Movie> movies;

  const LocalFavMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class LocalFavMoviesError extends LocalFavMoviesState {
  final String message;

  const LocalFavMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

final class LocalFavMoviesSearchLoaded extends LocalFavMoviesState {
  final List<Movie> movies;

  const LocalFavMoviesSearchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class LocalFavMoviesDeleteSuccess extends LocalFavMoviesState {}

final class LocalFavMoviesAddedSuccess extends LocalFavMoviesState {}
