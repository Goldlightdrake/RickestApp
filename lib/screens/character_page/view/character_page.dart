import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rickest_app/data/models/character.dart';
import 'package:rickest_app/logic/favorite_characters_cubit/favorite_characters_cubit.dart';
import 'package:rickest_app/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterPage extends StatelessWidget {
  final Character character;
  const CharacterPage({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var header = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: kSpacingUnit * 3),
          IconButton(
              onPressed: () => Navigator.of(context).pop<void>(),
              icon: Icon(LineIcons.arrowLeft),
              iconSize: kSpacingUnit * 3),
        ]);

    var characterHeader = Column(children: [
      Stack(alignment: Alignment.bottomLeft, children: [
        Hero(
          tag: character.id,
          child: CircleAvatar(
              backgroundImage: NetworkImage(character.image), radius: 72),
        ),
        Builder(builder: (context) {
          // ignore: close_sinks
          final favoriteChampionCubit =
              context.watch<FavoriteCharactersCubit>();
          return TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                if (favoriteChampionCubit.isCharacterFavorite(character)) {
                  favoriteChampionCubit.removeCharacterFromFavorite(character);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("You've deleted a hero from your favorites!"),
                  ));
                } else {
                  favoriteChampionCubit.addCharacterToFavorite(character);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("You've added a hero to your favorites!"),
                  ));
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff12b0c9),
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(Icons.star,
                      color:
                          favoriteChampionCubit.isCharacterFavorite(character)
                              ? kContrastColor
                              : Colors.white,
                      size: 36)));
        }),
      ]),
      Text(character.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: kSpacingUnit * 4.5)),
    ]);

    var characterDetails = Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            StatsElement(
              passedStat: character.status,
              descriptionOfStat: 'Status',
            ),
            StatsElement(
              passedStat: character.species,
              descriptionOfStat: 'Species',
            ),
            StatsElement(
              passedStat: character.type,
              descriptionOfStat: 'Type',
            ),
          ],
        ));
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(kSpacingUnit * 5),
        ),
        header,
        characterHeader,
        SizedBox(
          height: ScreenUtil().setHeight(kSpacingUnit * 3),
        ),
        characterDetails
      ],
    ));
  }
}

class StatsElement extends StatelessWidget {
  const StatsElement({
    Key? key,
    required this.descriptionOfStat,
    required this.passedStat,
  }) : super(key: key);

  final String descriptionOfStat;
  final String passedStat;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: ScreenUtil().setHeight(kSpacingUnit * 6),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 5), color: Theme.of(context).shadowColor),
            ],
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: ScreenUtil().setWidth(kSpacingUnit * 10),
                child: textWithStroke(
                    text: descriptionOfStat + ':', fontSize: kSpacingUnit * 2),
              ),
              Container(
                width: ScreenUtil().setWidth(kSpacingUnit * 20),
                alignment: Alignment.center,
                child: descriptionOfStat == "Status"
                    ? statusIcon(passedStat.toLowerCase())
                    : Text(
                        passedStat == '' ? "Brak danych" : passedStat,
                      ),
              ),
            ],
          ),
        ));
  }
}
