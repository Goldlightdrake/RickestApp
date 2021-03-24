import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickest_app/data/models/character.dart';

part 'listofcharacters_event.dart';
part 'listofcharacters_state.dart';

const _charactersLimit = 671;

class ListOfCharactersBloc
    extends Bloc<ListOfCharactersEvent, ListOfCharactersState> {
  final http.Client httpClient;

  ListOfCharactersBloc({required this.httpClient})
      : super(const ListOfCharactersState());

  @override
  Stream<Transition<ListOfCharactersEvent, ListOfCharactersState>>
      transformEvents(
    Stream<ListOfCharactersEvent> events,
    TransitionFunction<ListOfCharactersEvent, ListOfCharactersState>
        transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListOfCharactersState> mapEventToState(
      ListOfCharactersEvent event) async* {
    if (event is ListOfCharactersFetched) {
      yield await _mapCharactersFetchedToState(state);
    }
  }

  Future<ListOfCharactersState> _mapCharactersFetchedToState(
      ListOfCharactersState state) async {
    if (state.hasReachedMax) return state;
    print(state.status);
    try {
      if (state.status == ListOfCharactersStatus.initial) {
        print(state.status);
        final characters = await _fetchCharacters();
        return state.copyWith(
          status: ListOfCharactersStatus.success,
          characters: characters,
          hasReachedMax: _hasReachedMax(characters.length),
        );
      }
      final characters =
          await _fetchCharacters(state.characters.length ~/ 20 + 1);
      return characters.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ListOfCharactersStatus.success,
              characters: List.of(state.characters)..addAll(characters),
              hasReachedMax: _hasReachedMax(characters.length),
            );
    } on Exception {
      return state.copyWith(status: ListOfCharactersStatus.failure);
    }
  }

  Future<List<Character>> _fetchCharacters([int startIndex = 1]) async {
    http.Response response;

    response = await httpClient.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/?page=$startIndex'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final data = body['results'] as List;

      if (data.isEmpty) return [];

      return data.map((dynamic json) {
        return Character.fromMap(json);
      }).toList();
    } else {
      return [];
    }
  }

  bool _hasReachedMax(int charactersCount) =>
      charactersCount < _charactersLimit ? false : true;
}
