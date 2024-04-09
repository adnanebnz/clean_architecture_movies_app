part of 'local_fav_movies_bloc.dart';

sealed class LocalFavMoviesEvent extends Equatable {
  const LocalFavMoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchLocalFavMoviesEvent extends LocalFavMoviesEvent {
  const FetchLocalFavMoviesEvent();
}

final class DeleteLocalFavMovieEvent extends LocalFavMoviesEvent {
  final List<Movie> movies;

  const DeleteLocalFavMovieEvent(this.movies);

  @override
  List<Object> get props => [movies];
}

final class AddLocalFavMovieEvent extends LocalFavMoviesEvent {
  final Movie movie;

  const AddLocalFavMovieEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

final class SearchLocalMoviesEvent extends LocalFavMoviesEvent {
  final String query;

  const SearchLocalMoviesEvent(this.query);

  @override
  List<Object> get props => [query];
}
