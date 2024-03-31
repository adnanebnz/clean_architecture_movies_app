import 'package:movies_app/domain/entities/genre.dart';

class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Convert Genre toEntity
  Genre toEntity() {
    return Genre(
      id: id,
      name: name,
    );
  }
}
