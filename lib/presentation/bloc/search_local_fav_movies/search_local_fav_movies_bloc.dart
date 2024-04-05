import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/usecases/local/search_fav_movies.dart';

part 'search_local_fav_movies_event.dart';
part 'search_local_fav_movies_state.dart';

class SearchLocalFavMoviesBloc
    extends Bloc<SearchLocalFavMoviesEvent, SearchLocalFavMoviesState> {
  SearchFavMovies searchFavMovies;
  SearchLocalFavMoviesBloc({required this.searchFavMovies})
      : super(SearchLocalFavMoviesInitial()) {
    on<SearchLocalFavMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
