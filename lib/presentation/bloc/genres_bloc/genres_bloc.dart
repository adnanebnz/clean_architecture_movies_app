import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/genre.dart';
import 'package:movies_app/domain/usecases/remote/get_genres.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GetGenres getGenres;

  GenresBloc({required this.getGenres}) : super(GenresInitial()) {
    on<FetchGenres>((event, emit) async {
      emit(GenresLoading());
      final failureOrGenres = await getGenres();
      failureOrGenres.fold((failure) => emit(GenresError(failure.message)),
          (genres) => emit(GenresLoaded(genres)));
    });
  }
}
