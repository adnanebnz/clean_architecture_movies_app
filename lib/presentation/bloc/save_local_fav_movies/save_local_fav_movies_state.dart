part of 'save_local_fav_movies_bloc.dart';

sealed class SaveLocalFavMoviesState extends Equatable {
  const SaveLocalFavMoviesState();
  
  @override
  List<Object> get props => [];
}

final class SaveLocalFavMoviesInitial extends SaveLocalFavMoviesState {}
