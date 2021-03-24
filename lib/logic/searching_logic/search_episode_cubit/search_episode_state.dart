part of 'search_episode_cubit.dart';

abstract class SearchEpisodeState extends Equatable {
  const SearchEpisodeState();

  @override
  List<Object> get props => [];
}

class SearchEpisodeInitial extends SearchEpisodeState {}

class SearchEpisodeReady extends SearchEpisodeState {
  final List<String> charactersId;
  SearchEpisodeReady({
    required this.charactersId,
  });
  @override
  List<Object> get props => [charactersId];
}

class SearchEpisodeEmpty extends SearchEpisodeState {}
