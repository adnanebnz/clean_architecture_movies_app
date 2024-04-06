part of 'delete_local_fav_movies_bloc.dart';

sealed class DeleteLocalFavMoviesState extends Equatable {
  const DeleteLocalFavMoviesState();

  @override
  List<Object> get props => [];
}

final class DeleteLocalFavMoviesInitial extends DeleteLocalFavMoviesState {}

final class DeleteLocalFavMoviesLoading extends DeleteLocalFavMoviesState {}

final class DeleteLocalFavMoviesError extends DeleteLocalFavMoviesState {
  final String message;

  const DeleteLocalFavMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

final class DeleteLocalFavMoviesSuccess extends DeleteLocalFavMoviesState {}
