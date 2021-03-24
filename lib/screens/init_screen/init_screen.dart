import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickest_app/screens/home_screen/view/characters_list_page.dart';
import 'package:rickest_app/shared/functions.dart';
import 'package:rickest_app/shared/shared.dart';

import '../../app.dart';

class InitScreen extends StatefulWidget {
  InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CharactersListPage())));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      allowFontScaling: true,
      builder: () => Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/init_background.png'),
                  fit: BoxFit.cover)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 150),
          child:
              textWithStroke(text: 'Rickest App', fontSize: kSpacingUnit * 6),
        ),
      ),
    );
  }
}
