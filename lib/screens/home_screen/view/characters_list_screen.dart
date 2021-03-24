import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import 'package:rickest_app/data/shared_preference/user_preference.dart';
import 'package:rickest_app/logic/filter_cubit/filter_cubit.dart';
import 'package:rickest_app/logic/list_view_bloc/list_view_bloc.dart';
import 'package:rickest_app/logic/searching_logic/search_episode_cubit/search_episode_cubit.dart';
import 'package:rickest_app/logic/searching_logic/search_input_cubit/search_input_cubit.dart';
import 'package:rickest_app/shared/shared.dart';

import '../widgets/widgets.dart';

class CharactersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState:
              ThemeProvider.of(context)!.brightness == Brightness.dark
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () {
              ThemeSwitcher.of(context)!.changeTheme(theme: kLightTheme);
              UserSharedPreference.setThemeDataPrefs(true);
            },
            child: Icon(
              LineIcons.sun,
              size: kSpacingUnit * 3,
            ),
          ),
          secondChild: GestureDetector(
            onTap: () {
              ThemeSwitcher.of(context)!.changeTheme(theme: kDarkTheme);
              UserSharedPreference.setThemeDataPrefs(false);
            },
            child: Icon(
              LineIcons.moon,
              size: kSpacingUnit * 3,
            ),
          ),
        );
      },
    );
    return Scaffold(
        floatingActionButton: Builder(builder: (context) {
          final filterState = context.watch<FilterCubit>().state.filter;
          return ExpandableFab(
            distance: 70,
            children: [
              ActionButton(
                color: filterState != Filter.unknown
                    ? kAccentColor
                    : kContrastColor,
                onPressed: () {
                  filterState != Filter.unknown
                      ? context.read<FilterCubit>().changeFilter(Filter.unknown)
                      : context.read<FilterCubit>().changeFilter(Filter.none);
                },
                icon: Icon(LineIcons.question,
                    color: filterState != Filter.unknown
                        ? kContrastColor
                        : kAccentColor),
              ),
              ActionButton(
                color:
                    filterState != Filter.alive ? kAccentColor : kContrastColor,
                onPressed: () {
                  filterState != Filter.alive
                      ? context.read<FilterCubit>().changeFilter(Filter.alive)
                      : context.read<FilterCubit>().changeFilter(Filter.none);
                },
                icon: Icon(LineIcons.heartAlt,
                    color: filterState != Filter.alive
                        ? kContrastColor
                        : kAccentColor),
              ),
              ActionButton(
                color:
                    filterState != Filter.dead ? kAccentColor : kContrastColor,
                onPressed: () {
                  filterState != Filter.dead
                      ? context.read<FilterCubit>().changeFilter(Filter.dead)
                      : context.read<FilterCubit>().changeFilter(Filter.none);
                },
                icon: Icon(LineIcons.ghost,
                    color: filterState != Filter.dead
                        ? kContrastColor
                        : kAccentColor),
              ),
            ],
          );
        }),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              shadowColor: Theme.of(context).shadowColor,
              backgroundColor: Theme.of(context).backgroundColor,
              expandedHeight: 140.0,
              elevation: 10.0,
              floating: true,
              snap: true,
              centerTitle: true,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      themeSwitcher,
                      SizedBox(height: 5),
                      Builder(builder: (context) {
                        final listViewState =
                            context.watch<ListViewBloc>().state;
                        return GestureDetector(
                            child: Icon(Icons.star,
                                size: kSpacingUnit * 3,
                                color: listViewState.showFavoriteCharacters
                                    ? Colors.yellow
                                    : Colors.white),
                            onTap: () {
                              listViewState.showFavoriteCharacters
                                  ? context.read<ListViewBloc>().add(
                                      UpdatedListView(listOfCharacters: []))
                                  : context
                                      .read<ListViewBloc>()
                                      .add(FavoriteListView());
                            });
                      }),
                    ]),
                    textWithStroke(
                        text: 'Rickest App', fontSize: kSpacingUnit * 4),
                    Builder(builder: (context) {
                      final showInput = context.watch<SearchInputCubit>().state;
                      return Container(
                        width: kSpacingUnit * 3,
                        child: TextButton(
                            child: Icon(showInput ? Icons.clear : Icons.search,
                                color: Theme.of(context).iconTheme.color,
                                size: kSpacingUnit * 3),
                            onPressed: () {
                              if (showInput) {
                                context
                                    .read<ListViewBloc>()
                                    .add(UpdatedListView(listOfCharacters: []));
                                context
                                    .read<SearchEpisodeCubit>()
                                    .emit(SearchEpisodeInitial());
                              }

                              context
                                  .read<SearchInputCubit>()
                                  .toggleForInputView(!showInput);
                            }),
                      );
                    })
                  ]),
              flexibleSpace: FlexSpaceBar(),
            ),
            SliverPadding(padding: EdgeInsets.only(top: 10)),
            CharactersListWidget()
          ],
        ));
  }
}
