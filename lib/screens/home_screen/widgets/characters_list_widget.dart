import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickest_app/logic/list_of_characters_bloc/listofcharacters_bloc.dart';
import 'package:rickest_app/logic/list_view_bloc/list_view_bloc.dart';

import 'bottom_loader.dart';
import 'characters_list_item.dart';

class CharactersListWidget extends StatelessWidget {
  const CharactersListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, sliver) =>
          BlocBuilder<ListOfCharactersBloc, ListOfCharactersState>(
        builder: (context, state) {
          switch (state.status) {
            case ListOfCharactersStatus.failure:
              return SliverToBoxAdapter(
                child: const Center(child: Text('Something goes wrong..')),
              );
            case ListOfCharactersStatus.success:
              if (state.characters.isEmpty) {
                return SliverToBoxAdapter(
                  child: const Center(
                      child: Text('There is no characters to show..')),
                );
              }
              return BlocBuilder<ListViewBloc, ListViewState>(
                builder: (context, state) {
                  if (state.listOfCharacters.isEmpty) {
                    return SliverToBoxAdapter(
                      child: const Center(
                          child: Text('There is no characters to show..')),
                    );
                  }

                  if (state.showFavoriteCharacters ||
                      state.showResultsFromSearching) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return CharactersListItem(
                            character: state.listOfCharacters[index]);
                      }, childCount: state.listOfCharacters.length),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index >= state.listOfCharacters.length) {
                        context
                            .read<ListOfCharactersBloc>()
                            .add(ListOfCharactersFetched());
                      }
                      return index >= state.listOfCharacters.length
                          ? BottomLoader()
                          : CharactersListItem(
                              character: state.listOfCharacters[index]);
                    }, childCount: state.listOfCharacters.length + 1),
                  );
                },
              );
            default:
              return SliverToBoxAdapter(
                  child: const Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
