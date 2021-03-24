part of 'listofcharacters_bloc.dart';

enum ListOfCharactersStatus { initial, success, failure }

class ListOfCharactersState extends Equatable {
  const ListOfCharactersState({
    this.status = ListOfCharactersStatus.initial,
    this.characters = const <Character>[],
    this.hasReachedMax = false,
  });

  final ListOfCharactersStatus status;
  final List<Character> characters;
  final bool hasReachedMax;

  ListOfCharactersState copyWith({
    ListOfCharactersStatus? status,
    List<Character>? characters,
    bool? hasReachedMax,
  }) {
    return ListOfCharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, characters, hasReachedMax];
}
