part of 'favorite_characters_cubit.dart';

class FavoriteCharactersState extends Equatable {
  const FavoriteCharactersState({required this.favCharacters});
  final List<Character> favCharacters;

  FavoriteCharactersState copyWith({
    List<Character>? favCharacters,
  }) {
    return FavoriteCharactersState(
      favCharacters: favCharacters ?? this.favCharacters,
    );
  }

  @override
  List<Object> get props => [favCharacters];

  Map<String, dynamic> toMap() {
    return {
      'favCharacters': favCharacters.map((x) => x.toMap()).toList(),
    };
  }

  factory FavoriteCharactersState.fromMap(Map<String, dynamic> map) {
    return FavoriteCharactersState(
      favCharacters: List<Character>.from(
          map['favCharacters']?.map((x) => Character.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteCharactersState.fromJson(String source) =>
      FavoriteCharactersState.fromMap(json.decode(source));
}
