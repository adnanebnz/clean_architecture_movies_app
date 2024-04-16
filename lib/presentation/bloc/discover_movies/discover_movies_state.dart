part of 'discover_movies_bloc.dart';

sealed class DiscoverMoviesState extends Equatable {
  const DiscoverMoviesState();

  @override
  List<Object> get props => [];
}

final class DiscoverMoviesInitial extends DiscoverMoviesState {}

final class DiscoverMoviesLoading extends DiscoverMoviesState {}

final class DiscoverMoviesLoaded extends DiscoverMoviesState {
  final List<Movie> movies;
  const DiscoverMoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class DiscoverMoviesError extends DiscoverMoviesState {
  final String message;
  const DiscoverMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
