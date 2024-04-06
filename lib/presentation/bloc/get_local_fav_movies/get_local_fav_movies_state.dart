part of 'get_local_fav_movies_bloc.dart';

sealed class GetLocalFavMoviesState extends Equatable {
  const GetLocalFavMoviesState();

  @override
  List<Object?> get props => [];
}

final class GetLocalFavMoviesInitial extends GetLocalFavMoviesState {}

final class GetLocalFavMoviesLoading extends GetLocalFavMoviesState {}

final class GetLocalFavMoviesLoaded extends GetLocalFavMoviesState {
  final List<Movie> movies;

  const GetLocalFavMoviesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class GetLocalFavMoviesError extends GetLocalFavMoviesState {
  final String message;
  const GetLocalFavMoviesError(this.message);
}
