import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/movie.dart';

sealed class TrendingMoviesState extends Equatable {
  const TrendingMoviesState();

  @override
  List<Object> get props => [];
}

final class TrendingMoviesInitial extends TrendingMoviesState {}

final class TrendingMoviesLoading extends TrendingMoviesState {}

final class TrendingMoviesLoaded extends TrendingMoviesState {
  final List<Movie> movies;
  const TrendingMoviesLoaded(this.movies);
}

class TrendingMoviesError extends TrendingMoviesState {
  final String message;
  const TrendingMoviesError(this.message);
}
