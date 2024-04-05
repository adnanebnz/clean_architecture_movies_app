part of 'save_local_fav_movies_bloc.dart';

sealed class SaveLocalFavMoviesEvent extends Equatable {
  const SaveLocalFavMoviesEvent();

  @override
  List<Object> get props => [];
}

final class SaveLocalFavMoviesEventSave extends SaveLocalFavMoviesEvent {
  final Movie movie;

  const SaveLocalFavMoviesEventSave(this.movie);

  @override
  List<Object> get props => [movie];
}
