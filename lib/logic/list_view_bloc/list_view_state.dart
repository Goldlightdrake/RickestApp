part of 'list_view_bloc.dart';

class ListViewState extends Equatable {
  const ListViewState({
    required this.listOfCharacters,
    required this.activeFilter,
    required this.showFavoriteCharacters,
    required this.showResultsFromSearching,
  });

  final List<Character> listOfCharacters;
  final Filter activeFilter;
  final bool showFavoriteCharacters;
  final bool showResultsFromSearching;

  @override
  List<Object> get props => [
        listOfCharacters,
        activeFilter,
        showFavoriteCharacters,
        showResultsFromSearching
      ];

  ListViewState copyWith(
      {List<Character>? listOfCharacters,
      Filter? activeFilter,
      bool? showFavoriteCharacters,
      bool? showResultsFromSearching}) {
    return ListViewState(
      listOfCharacters: listOfCharacters ?? this.listOfCharacters,
      activeFilter: activeFilter ?? this.activeFilter,
      showFavoriteCharacters:
          showFavoriteCharacters ?? this.showFavoriteCharacters,
      showResultsFromSearching:
          showResultsFromSearching ?? this.showResultsFromSearching,
    );
  }

  @override
  String toString() {
    return "ListViewState {$listOfCharacters}";
  }
}
