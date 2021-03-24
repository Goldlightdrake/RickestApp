import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'dart:convert';
import 'package:rickest_app/data/models/character.dart';

part 'favorite_characters_state.dart';

class FavoriteCharactersCubit extends Cubit<FavoriteCharactersState>
    with HydratedMixin {
  FavoriteCharactersCubit() : super(FavoriteCharactersState(favCharacters: []));

  void addCharacterToFavorite(Character character) {
    emit(state.copyWith(
        favCharacters: List.of(state.favCharacters)..add(character)));
  }

  void removeCharacterFromFavorite(Character character) {
    if (isCharacterFavorite(character)) {
      emit(state.copyWith(
          favCharacters: List.of(state.favCharacters)..remove(character)));
    }
  }

  bool isCharacterFavorite(Character character) {
    return state.favCharacters.contains(character);
  }

  @override
  FavoriteCharactersState? fromJson(Map<String, dynamic> json) {
    return FavoriteCharactersState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoriteCharactersState state) {
    return state.toMap();
  }
}
