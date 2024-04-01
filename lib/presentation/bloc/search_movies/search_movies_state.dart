part of 'search_movies_bloc.dart';

sealed class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

final class SearchMoviesInitial extends SearchMoviesState {}

final class SearchMoviesLoading extends SearchMoviesState {}

final class SearchMoviesLoaded extends SearchMoviesState {
  final List<Movie> movies;
  final int? nextPageKey;

  const SearchMoviesLoaded(this.movies, this.nextPageKey);
}

final class SearchMoviesError extends SearchMoviesState {
  final String message;
  const SearchMoviesError(this.message);
}
