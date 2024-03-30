import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
    });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<PopularMoviesBloc>().add(FetchNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        if (state is PopularMoviesLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              return MovieCard(state.movies[index]);
            },
          );
        } else if (state is PopularMoviesLoading) {
          return const CircularProgressIndicator();
        } else {
          return const Text('Error');
        }
      },
    );
  }
}
