import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/movie.dart';

sealed class TrendingMoviesState extends Equatable {
  const TrendingMoviesState();

  @override
  List<Object?> get props => [];
}

final class TrendingMoviesInitial extends TrendingMoviesState {}

final class TrendingMoviesLoading extends TrendingMoviesState {}

final class TrendingMoviesLoaded extends TrendingMoviesState {
  final List<Movie> movies;
  final int? nextPageKey;

  const TrendingMoviesLoaded(this.movies, this.nextPageKey);

  @override
  List<Object?> get props => [movies, nextPageKey];
}

class TrendingMoviesError extends TrendingMoviesState {
  final String message;
  const TrendingMoviesError(this.message);
}
