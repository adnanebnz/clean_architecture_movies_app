part of 'get_local_fav_movies_bloc.dart';

sealed class GetLocalFavMoviesState extends Equatable {
  const GetLocalFavMoviesState();
  
  @override
  List<Object> get props => [];
}

final class GetLocalFavMoviesInitial extends GetLocalFavMoviesState {}
