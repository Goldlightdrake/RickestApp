import 'dart:convert';

import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String image;
  final List<String> episode;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.image,
    required this.episode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'image': image,
      'episode': episode,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      species: map['species'],
      type: map['type'],
      image: map['image'],
      episode: List<String>.from(map['episode']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source));

  @override
  List<Object?> get props => [id, name, status, species, type, image, episode];

  @override
  String toString() {
    return "Character $id {name: $name; status: $status; species: $species; type: $type; image: $image; episodes: $episode;}";
  }
}
