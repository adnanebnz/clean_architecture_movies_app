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
          (movies) => emit(SearchMoviesLoaded(movies, currentPage + 1)));
    });
    on<FetchNextPage>((event, emit) async {
      currentPage = event.pageKey;
      emit(SearchMoviesLoading());
      final failureOrMovies = await searchMovies(event.query, currentPage);
      failureOrMovies.fold(
        (failure) => emit(SearchMoviesError(failure.message)),
        (movies) {
          final nextPageKey = movies.isEmpty ? null : currentPage + 1;
          emit(SearchMoviesLoaded(movies, nextPageKey));
        },
      );
    });

    on<ResetSearchMovies>((event, emit) {
      emit(SearchMoviesInitial());
    });
  }
}
