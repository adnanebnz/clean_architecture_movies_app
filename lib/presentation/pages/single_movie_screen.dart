import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/genre.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movies_app/presentation/bloc/local_fav_movies/local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movie_trailer/movie_trailer_bloc.dart';
import 'package:movies_app/presentation/widgets/genres_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleMovieScreen extends StatefulWidget {
  const SingleMovieScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<SingleMovieScreen> createState() => _SingleMovieScreenState();
}

class _SingleMovieScreenState extends State<SingleMovieScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
    );
    context.read<MovieTrailerBloc>().add(GetMovieTrailer(widget.movie.title));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTrailerBloc, MovieTrailerState>(
      builder: (context, state) {
        if (state is MovieTrailerLoaded) {
          _controller = YoutubePlayerController(
            initialVideoId: state.videos[0].videoId!,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );
        }
        return YoutubePlayerBuilder(
          builder: (context, player) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
              body: ListView(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        widget.movie.posterPath == ""
                            ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
                            : 'https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: BlocBuilder<LocalFavMoviesBloc,
                            LocalFavMoviesState>(
                          builder: (context, state) {
                            bool isFavorite = false;
                            if (state is LocalFavMoviesLoaded) {
                              isFavorite = state.movies
                                  .any((movie) => movie.id == widget.movie.id);
                            }
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]),
                              child: IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  if (isFavorite) {
                                    context.read<LocalFavMoviesBloc>().add(
                                          DeleteLocalFavMovieEvent(
                                              [widget.movie]),
                                        );
                                  } else {
                                    context.read<LocalFavMoviesBloc>().add(
                                          AddLocalFavMovieEvent(widget.movie),
                                        );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 14,
                                      ),
                                      Text(
                                        widget.movie.voteAverage
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // vote count
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.people,
                                        size: 14,
                                      ),
                                      Text(
                                        widget.movie.voteCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            size: 20,
                                          ),
                                          Text(
                                            widget.movie.isAdult
                                                ? "Adult"
                                                : "Family",
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              widget.movie.releaseDate,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // is adult
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Genres",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        // ADD MOVIE TO FAV
                        BlocBuilder<GenresBloc, GenresState>(
                          builder: (context, state) {
                            if (state is GenresLoaded) {
                              List<Genre> movieGenres = state.genres
                                  .where((genre) =>
                                      widget.movie.genreIds.contains(genre.id))
                                  .toList();

                              return GenreList(genres: movieGenres);
                            } else if (state is GenresError) {
                              return Text('Error: ${state.message}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                        const SizedBox(height: 14),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Synopsis",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.movie.overview,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    ),
                  ),
                  if (state is MovieTrailerLoaded)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: player,
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[100]!.withAlpha(100),
                        highlightColor: Colors.grey[300]!.withAlpha(100),
                        child: Container(
                          width: double.infinity,
                          height: 180.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          player: YoutubePlayer(controller: _controller),
        );
      },
    );
  }
}
