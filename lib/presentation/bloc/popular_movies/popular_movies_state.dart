part of 'popular_movies_bloc.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

final class PopularMoviesInitial extends PopularMoviesState {}

final class PopularMoviesLoading extends PopularMoviesState {}

final class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie> movies;
  const PopularMoviesLoaded(this.movies);
}

final class PopularMoviesError extends PopularMoviesState {
  final String message;
  const PopularMoviesError(this.message);
}
