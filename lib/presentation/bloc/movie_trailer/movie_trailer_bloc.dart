import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/core/exceptions/failure.dart';
import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_data_api/youtube_data_api.dart';

part 'movie_trailer_event.dart';
part 'movie_trailer_state.dart';

class MovieTrailerBloc extends Bloc<MovieTrailerEvent, MovieTrailerState> {
  YoutubeDataApi ytManager;
  MovieTrailerBloc({required this.ytManager}) : super(MovieTrailerInitial()) {
    on<GetMovieTrailer>((event, emit) async {
      emit(MovieTrailerLoading());
      try {
        final List res = await ytManager.fetchSearchVideo(
            "${event.query} Official Trailer", dotenv.env['YT_API_KEY']!);

        List<Video> videos = res.whereType<Video>().toList();
        if (videos.isNotEmpty) {
          emit(MovieTrailerLoaded(videos));
        } else {
          emit(MovieTrailerError(
              Failure(message: "No trailer found").toString()));
        }
      } catch (e) {
        emit(MovieTrailerError(Failure(message: e.toString()).toString()));
      }
    });
  }
}
