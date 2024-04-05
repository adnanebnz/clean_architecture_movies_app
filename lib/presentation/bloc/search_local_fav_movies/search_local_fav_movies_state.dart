part of 'search_local_fav_movies_bloc.dart';

sealed class SearchLocalFavMoviesState extends Equatable {
  const SearchLocalFavMoviesState();
  
  @override
  List<Object> get props => [];
}

final class SearchLocalFavMoviesInitial extends SearchLocalFavMoviesState {}
