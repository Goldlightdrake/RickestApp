import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickest_app/screens/home_screen/view/characters_list_page.dart';
import 'package:rickest_app/shared/theme.dart';

import 'data/shared_preference/user_preference.dart';
import 'logic/favorite_characters_cubit/favorite_characters_cubit.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      allowFontScaling: false,
      builder: () => FutureBuilder<bool>(
        future: UserSharedPreference.getThemeDataPrefs(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return ThemeProvider(
                initTheme: snapshot.data! ? kLightTheme : kDarkTheme,
                child: Builder(builder: (context) {
                  return BlocProvider(
                    create: (context) => FavoriteCharactersCubit(),
                    child: MaterialApp(
                      title: 'RickestApp',
                      home: CharactersListPage(),
                      theme: ThemeProvider.of(context),
                      debugShowCheckedModeBanner: false,
                    ),
                  );
                }));
          }
          return Container();
        },
      ),
    );
  }
}
