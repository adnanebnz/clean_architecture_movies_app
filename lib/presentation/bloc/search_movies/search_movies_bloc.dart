import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/usecases/search_movie.dart';
import 'package:movies_app/presentation/bloc/search_movies/search_movies_event.dart';

part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;
  int currentPage = 1;
  SearchMoviesBloc({required this.searchMovies})
      : super(SearchMoviesInitial()) {
    on<FetchSearchMovies>((event, emit) async {
      emit(SearchMoviesLoading());
      final failureOrMovies = await searchMovies(event.query, currentPage);
      failureOrMovies.fold(
          (failure) => emit(SearchMoviesError(failure.message)),
          (movies) => emit(SearchMoviesLoaded(movies)));
    });
    on<FetchNextPage>((event, emit) async {
      currentPage = event.pageKey;
      emit(SearchMoviesLoading());
      final failureOrMovies = await searchMovies(event.query, currentPage);
      failureOrMovies.fold(
          (failure) => emit(SearchMoviesError(failure.message)), (movies) {
        if (state is SearchMoviesLoaded) {
          final previousState = state as SearchMoviesLoaded;
          final updatedMovies = List<Movie>.from(previousState.movies)
            ..addAll(movies);
          emit(SearchMoviesLoaded(updatedMovies));
        } else {
          emit(SearchMoviesLoaded(movies));
        }
      });
    });
  }
}
