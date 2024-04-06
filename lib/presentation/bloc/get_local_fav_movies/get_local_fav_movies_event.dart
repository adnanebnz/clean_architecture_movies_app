part of 'get_local_fav_movies_bloc.dart';

sealed class GetLocalFavMoviesEvent extends Equatable {
  const GetLocalFavMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchFavMovies extends GetLocalFavMoviesEvent {}
