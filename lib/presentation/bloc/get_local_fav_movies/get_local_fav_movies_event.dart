part of 'get_local_fav_movies_bloc.dart';

sealed class GetLocalFavMoviesEvent extends Equatable {
  const GetLocalFavMoviesEvent();

  @override
  List<Object> get props => [];
}

final class GetLocalFavMoviesEventGet extends GetLocalFavMoviesEvent {}

final class GetLocalFavMoviesEventDelete extends GetLocalFavMoviesEvent {
  final Movie movie;

  const GetLocalFavMoviesEventDelete(this.movie);

  @override
  List<Object> get props => [movie];
}

final class GetLocalFavMoviesEventCheck extends GetLocalFavMoviesEvent {
  final Movie movie;

  const GetLocalFavMoviesEventCheck(this.movie);

  @override
  List<Object> get props => [movie];
}
