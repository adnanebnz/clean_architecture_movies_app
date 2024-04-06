import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/bloc/delete_local_fav_movies/delete_local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/get_local_fav_movies/get_local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/pages/single_movie_screen.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class LocalFavMoviesScreen extends StatefulWidget {
  const LocalFavMoviesScreen({super.key});

  @override
  State<LocalFavMoviesScreen> createState() => _LocalFavMoviesScreenState();
}

class _LocalFavMoviesScreenState extends State<LocalFavMoviesScreen> {
  List<Movie> selectedMovies = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      context.read<GetLocalFavMoviesBloc>().add(FetchFavMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selectedMovies.isEmpty
            ? const Text("Favorite Movies")
            : Text("${selectedMovies.length} selected"),
        actions: [
          if (selectedMovies.isNotEmpty)
            BlocBuilder<DeleteLocalFavMoviesBloc, DeleteLocalFavMoviesState>(
              builder: (context, state) {
                if (state is DeleteLocalFavMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DeleteLocalFavMoviesError) {
                  return Text(state.message);
                }
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context
                        .read<DeleteLocalFavMoviesBloc>()
                        .add(DeleteFavMovies(selectedMovies));
                    setState(() {
                      selectedMovies.clear();
                    });
                  },
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetLocalFavMoviesBloc, GetLocalFavMoviesState>(
          builder: (context, state) {
            if (state is GetLocalFavMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetLocalFavMoviesError) {
              return Text('Error: ${state.message}');
            } else if (state is GetLocalFavMoviesLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return GestureDetector(
                    onLongPress: () {
                      setState(() {
                        if (selectedMovies.contains(movie)) {
                          selectedMovies.remove(movie);
                        } else {
                          selectedMovies.add(movie);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: selectedMovies.contains(movie)
                            ? Border.all(
                                color: Colors.blue,
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: MovieCard(
                        movie,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SingleMovieScreen(movie: movie)),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
