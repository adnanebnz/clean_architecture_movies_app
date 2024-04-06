part of 'movie_trailer_bloc.dart';

sealed class MovieTrailerEvent extends Equatable {
  const MovieTrailerEvent();

  @override
  List<Object> get props => [];
}

class GetMovieTrailer extends MovieTrailerEvent {
  final String query;

  const GetMovieTrailer(this.query);

  @override
  List<Object> get props => [query];
}
