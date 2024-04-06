part of 'delete_local_fav_movies_bloc.dart';

sealed class DeleteLocalFavMoviesEvent extends Equatable {
  const DeleteLocalFavMoviesEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavMovies extends DeleteLocalFavMoviesEvent {
  final List<Movie> movies;

  const DeleteFavMovies(this.movies);

  @override
  List<Object> get props => [movies];
}
