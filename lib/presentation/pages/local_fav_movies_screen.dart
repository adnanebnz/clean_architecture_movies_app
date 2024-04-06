import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/bloc/get_local_fav_movies/get_local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/pages/single_movie_screen.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class LocalFavMoviesScreen extends StatelessWidget {
  const LocalFavMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetLocalFavMoviesBloc>().add(FetchFavMovies());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite movies"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: BlocConsumer<GetLocalFavMoviesBloc, GetLocalFavMoviesState>(
          listener: (context, state) {
            if (state is GetLocalFavMoviesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is GetLocalFavMoviesLoading) {
              return const CircularProgressIndicator();
            } else if (state is GetLocalFavMoviesError) {
              return Center(child: Text(state.message));
            } else if (state is GetLocalFavMoviesLoaded) {
              return GridView.builder(
                itemCount: state.movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(
                    movie,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleMovieScreen(movie: movie),
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
