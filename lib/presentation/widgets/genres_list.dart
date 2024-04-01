import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/genre.dart';

class GenreList extends StatelessWidget {
  const GenreList({super.key, required this.genres});

  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: genres.map((genre) {
          return Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white24,
            ),
            child: Text(
              genre.name,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ),
    );
  }
}
