import 'package:flutter/material.dart';
import 'package:rickest_app/data/models/character.dart';
import 'package:rickest_app/screens/character_page/view/character_page.dart';
import 'package:rickest_app/shared/theme.dart';

class CharactersListItem extends StatelessWidget {
  const CharactersListItem({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CharacterPage(
                  character: character,
                )),
      ),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).backgroundColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).shadowColor, offset: Offset(2, 4))
              ]),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Hero(
                  tag: character.id,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(character.image),
                      radius: 24),
                ),
              ),
              Text(
                character.name.length > 34
                    ? "Nie wiem jak go mama wołała :c"
                    : character.name,
                style: kTitleTextStyle.copyWith(fontSize: kSpacingUnit * 1.5),
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          )),
    );
  }
}
