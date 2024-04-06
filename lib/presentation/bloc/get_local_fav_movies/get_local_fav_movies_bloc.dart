import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/usecases/local/get_fav_movies.dart';

part 'get_local_fav_movies_event.dart';
part 'get_local_fav_movies_state.dart';

class GetLocalFavMoviesBloc
    extends Bloc<GetLocalFavMoviesEvent, GetLocalFavMoviesState> {
  GetFavMovies getFavMovies;
  GetLocalFavMoviesBloc({required this.getFavMovies})
      : super(GetLocalFavMoviesInitial()) {
    on<FetchFavMovies>((event, emit) async {
      emit(GetLocalFavMoviesLoading());
      final failureOrMovies = await getFavMovies();
      failureOrMovies.fold(
        (failure) => emit(GetLocalFavMoviesError(failure.message)),
        (movies) => emit(GetLocalFavMoviesLoaded(movies)),
      );
    });
  }
}
