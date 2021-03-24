import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:rickest_app/logic/favorite_characters_cubit/favorite_characters_cubit.dart';
import 'package:rickest_app/logic/filter_cubit/filter_cubit.dart';
import 'package:rickest_app/logic/list_of_characters_bloc/listofcharacters_bloc.dart';
import 'package:rickest_app/logic/list_view_bloc/list_view_bloc.dart';
import 'package:rickest_app/logic/searching_logic/search_episode_cubit/search_episode_cubit.dart';
import 'package:rickest_app/logic/searching_logic/search_input_cubit/search_input_cubit.dart';
import 'package:rickest_app/screens/home_screen/view/characters_list_screen.dart';

class CharactersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SearchInputCubit(),
          ),
          BlocProvider(
              create: (_) => ListOfCharactersBloc(
                    httpClient: http.Client(),
                  )..add(ListOfCharactersFetched())),
          BlocProvider(
            create: (_) => FilterCubit(),
          ),
          BlocProvider(
            create: (_) => SearchEpisodeCubit(
              httpClient: http.Client(),
            ),
          ),
        ],
        child: Builder(
            builder: (context) => BlocProvider(
                create: (_) => ListViewBloc(
                    searchEpisodeCubit: context.read<SearchEpisodeCubit>(),
                    favoriteCharactersCubit:
                        context.read<FavoriteCharactersCubit>(),
                    filterCubit: context.read<FilterCubit>(),
                    listOfCharactersBloc: context.read<ListOfCharactersBloc>())
                  ..add(UpdatedListView(
                      listOfCharacters: context
                          .read<ListOfCharactersBloc>()
                          .state
                          .characters)),
                child: CharactersList())),
      ),
    );
  }
}
