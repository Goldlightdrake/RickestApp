part of 'listofcharacters_bloc.dart';

abstract class ListOfCharactersEvent extends Equatable {
  const ListOfCharactersEvent();

  @override
  List<Object> get props => [];
}

class ListOfCharactersFetched extends ListOfCharactersEvent {}
