import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rickest_app/data/models/character.dart';
import 'package:rickest_app/logic/favorite_characters_cubit/favorite_characters_cubit.dart';
import 'package:rickest_app/logic/filter_cubit/filter_cubit.dart';
import 'package:rickest_app/logic/list_of_characters_bloc/listofcharacters_bloc.dart';
import 'package:rickest_app/logic/searching_logic/search_episode_cubit/search_episode_cubit.dart';
import 'package:rickest_app/shared/enum.dart';

part 'list_view_event.dart';
part 'list_view_state.dart';

class ListViewBloc extends Bloc<ListViewEvent, ListViewState> {
  final ListOfCharactersBloc listOfCharactersBloc;
  final FilterCubit filterCubit;
  final FavoriteCharactersCubit favoriteCharactersCubit;
  final SearchEpisodeCubit searchEpisodeCubit;
  late StreamSubscription listSubscription;
  late StreamSubscription filterSubscription;
  late StreamSubscription episodeSearchSubscription;
  ListViewBloc({
    required this.listOfCharactersBloc,
    required this.filterCubit,
    required this.favoriteCharactersCubit,
    required this.searchEpisodeCubit,
  }) : super(ListViewState(
            listOfCharacters: [],
            activeFilter: Filter.none,
            showFavoriteCharacters: false,
            showResultsFromSearching: false)) {
    listSubscription = listOfCharactersBloc.stream.listen((state) {
      if (state.status == ListOfCharactersStatus.success) {
        add(UpdatedListView(listOfCharacters: state.characters));
      }
    });
    filterSubscription = filterCubit.stream.listen((state) {
      add(FiltredListView(filter: state.filter));
    });
    episodeSearchSubscription = searchEpisodeCubit.stream.listen((state) {
      if (state is SearchEpisodeReady) {
        add(EpisodeListView(charactersId: state.charactersId));
        searchEpisodeCubit.emit(SearchEpisodeInitial());
      }
    });
  }

  @override
  Stream<ListViewState> mapEventToState(
    ListViewEvent event,
  ) async* {
    if (event is FiltredListView) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is UpdatedListView) {
      yield* _mapCharactersUpdatedToState(event);
    } else if (event is EpisodeListView) {
      yield* _mapEpisodeSearchToState(event);
    } else if (event is FavoriteListView) {
      yield state.copyWith(
          listOfCharacters: favoriteCharactersCubit.state.favCharacters,
          showFavoriteCharacters: true,
          showResultsFromSearching: false);
    }
  }

  Stream<ListViewState> _mapFilterUpdatedToState(
    FiltredListView event,
  ) async* {
    if (listOfCharactersBloc.state.status == ListOfCharactersStatus.success) {
      yield state.copyWith(
          listOfCharacters: _mapCharactersToFilteredList(
            (listOfCharactersBloc.state).characters,
            event.filter,
          ),
          activeFilter: event.filter,
          showFavoriteCharacters: false,
          showResultsFromSearching: false);
    }
  }

  Stream<ListViewState> _mapCharactersUpdatedToState(
    UpdatedListView event,
  ) async* {
    final visibilityFilter = state.activeFilter;
    yield state.copyWith(
        listOfCharacters: _mapCharactersToFilteredList(
          listOfCharactersBloc.state.characters,
          visibilityFilter,
        ),
        showFavoriteCharacters: false,
        showResultsFromSearching: false);
  }

  Stream<ListViewState> _mapEpisodeSearchToState(
    EpisodeListView event,
  ) async* {
    if (listOfCharactersBloc.state.status == ListOfCharactersStatus.success) {
      yield state.copyWith(
          listOfCharacters: _mapCharactersToEpisodeList(
            (listOfCharactersBloc.state).characters,
            event.charactersId,
          ),
          showFavoriteCharacters: false,
          showResultsFromSearching: true);
    }
  }

  List<Character> _mapCharactersToFilteredList(
      List<Character> characters, Filter filter) {
    return characters.where((character) {
      if (filter == Filter.none) {
        return true;
      } else if (filter == Filter.alive) {
        return character.status.toLowerCase() == 'alive';
      } else if (filter == Filter.dead) {
        return character.status.toLowerCase() == 'dead';
      } else {
        return character.status.toLowerCase() == 'unknown';
      }
    }).toList();
  }

  List<Character> _mapCharactersToEpisodeList(
    List<Character> characters,
    List<String> charactersId,
  ) {
    return characters.where((character) {
      if (charactersId.contains(character.id.toString())) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Future<void> close() {
    listSubscription.cancel();
    filterSubscription.cancel();
    episodeSearchSubscription.cancel();

    return super.close();
  }
}
