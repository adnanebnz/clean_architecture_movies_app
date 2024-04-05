part of 'save_local_fav_movies_bloc.dart';

sealed class SaveLocalFavMoviesState extends Equatable {
  const SaveLocalFavMoviesState();

  @override
  List<Object> get props => [];
}

final class SaveLocalFavMoviesInitial extends SaveLocalFavMoviesState {}

final class SaveFavMoviesLoading extends SaveLocalFavMoviesState {}

final class SaveFavMoviesError extends SaveLocalFavMoviesState {
  final String message;

  const SaveFavMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

final class SaveFavMoviesSuccess extends SaveLocalFavMoviesState {}
