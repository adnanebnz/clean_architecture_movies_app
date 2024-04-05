part of 'get_local_fav_movies_bloc.dart';

sealed class GetLocalFavMoviesState extends Equatable {
  const GetLocalFavMoviesState();

  @override
  List<Object> get props => [];
}

final class GetLocalFavMoviesInitial extends GetLocalFavMoviesState {}

final class GetLocalFavMoviesLoading extends GetLocalFavMoviesState {}

final class GetLocalFavMoviesError extends GetLocalFavMoviesState {
  final String message;

  const GetLocalFavMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

final class GetLocalFavMoviesSuccess extends GetLocalFavMoviesState {
  final List<Movie> movies;

  const GetLocalFavMoviesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}
