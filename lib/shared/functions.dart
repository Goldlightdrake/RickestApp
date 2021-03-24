import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rickest_app/shared/theme.dart';

import 'enum.dart';

String statusOfCharacter(Filter filter) {
  switch (filter) {
    case Filter.alive:
      return "alive";
    case Filter.dead:
      return "dead";
    case Filter.unknown:
      return "unknown";
    default:
      return "none";
  }
}

Widget textWithStroke(
    {required String text,
    String fontFamily = 'get-schwifty',
    double fontSize: kSpacingUnit * 3,
    double strokeWidth: 1.2,
    Color textColor: const Color(0xff12b0c9),
    Color strokeColor: const Color(0xffcbde61)}) {
  return Stack(
    children: <Widget>[
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..color = strokeColor,
        ),
      ),
      Text(text,
          style: TextStyle(
              fontFamily: fontFamily, fontSize: fontSize, color: textColor)),
    ],
  );
}

Icon statusIcon(String status) {
  if (status == "dead") {
    return Icon(LineIcons.ghost, size: kSpacingUnit * 3, color: Colors.black54);
  } else if (status == "alive") {
    return Icon(LineIcons.heartAlt, size: kSpacingUnit * 3, color: Colors.red);
  } else {
    return Icon(LineIcons.question,
        size: kSpacingUnit * 3, color: Colors.orange);
  }
}
