import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;


part 'search_episode_state.dart';

class SearchEpisodeCubit extends Cubit<SearchEpisodeState> {
  final http.Client httpClient;

  SearchEpisodeCubit({
    required this.httpClient,
  }) : super(SearchEpisodeInitial());

  void searchForEpisode(String userInput) async {
    http.Response response;
    String episodeName = userInput;

    response = await httpClient.get(Uri.parse(
        'https://rickandmortyapi.com/api/episode/?name=$episodeName'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final data = body['results'] as List;

      if (data.isEmpty) {
        emit(SearchEpisodeEmpty());
      }

      final charactersId = gettingCharactersId(data);

      emit(SearchEpisodeReady(charactersId: charactersId));
    } else {
      emit(SearchEpisodeEmpty());
    }
  }

  List<String> gettingCharactersId(List data) {
    List<String> urlsToCharacters = [];

    data.forEach((episode) {
      episode['characters'].forEach((characterUrl) {
        urlsToCharacters.add(characterUrl);
      });
    });

    urlsToCharacters = urlsToCharacters.toSet().toList();

    List<String> charactersId = [];
    urlsToCharacters.forEach((characterUrl) {
      charactersId.add(characterUrl.split('/')[5]);
    });

    return charactersId;
  }
}
