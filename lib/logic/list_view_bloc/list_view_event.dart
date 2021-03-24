part of 'list_view_bloc.dart';

abstract class ListViewEvent extends Equatable {
  const ListViewEvent();

  @override
  List<Object> get props => [];
}

class UpdatedListView extends ListViewEvent {
  final List<Character> listOfCharacters;
  UpdatedListView({
    required this.listOfCharacters,
  });

  @override
  List<Object> get props => [listOfCharacters];
}

class FiltredListView extends ListViewEvent {
  final Filter filter;
  FiltredListView({
    required this.filter,
  });

  @override
  List<Object> get props => [filter];
}

class FavoriteListView extends ListViewEvent {}

class EpisodeListView extends ListViewEvent {
  final List<String> charactersId;
  EpisodeListView({
    required this.charactersId,
  });

  EpisodeListView copyWith({
    List<String>? charactersId,
  }) {
    return EpisodeListView(
      charactersId: charactersId ?? this.charactersId,
    );
  }

  @override
  List<Object> get props => [charactersId];
}
