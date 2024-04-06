part of 'movie_trailer_bloc.dart';

sealed class MovieTrailerState extends Equatable {
  const MovieTrailerState();

  @override
  List<Object> get props => [];
}

final class MovieTrailerInitial extends MovieTrailerState {}

final class MovieTrailerLoading extends MovieTrailerState {}

final class MovieTrailerLoaded extends MovieTrailerState {
  final List<Video> videos;

  const MovieTrailerLoaded(this.videos);

  @override
  List<Object> get props => [videos];
}

final class MovieTrailerError extends MovieTrailerState {
  final String message;

  const MovieTrailerError(this.message);

  @override
  List<Object> get props => [message];
}
