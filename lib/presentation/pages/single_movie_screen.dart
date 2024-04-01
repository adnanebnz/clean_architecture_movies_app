import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie.dart';

class SingleMovieScreen extends StatefulWidget {
  const SingleMovieScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<SingleMovieScreen> createState() => _SingleMovieScreenState();
}

class _SingleMovieScreenState extends State<SingleMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                widget.movie.posterPath == ""
                    ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
                    : 'https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // rating and release date
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
                                    size: 20,
                                  ),
                                  Text(
                                    widget.movie.voteAverage.toStringAsFixed(2),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
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
                                    size: 20,
                                  ),
                                  Text(
                                    widget.movie.voteCount.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.movie.releaseDate,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    // is adult
                    const SizedBox(height: 14),
                    const Text("Synopsis",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      widget.movie.overview,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
