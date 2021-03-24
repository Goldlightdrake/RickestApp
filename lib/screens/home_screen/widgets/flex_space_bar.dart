import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickest_app/logic/searching_logic/search_episode_cubit/search_episode_cubit.dart';

import 'package:rickest_app/logic/searching_logic/search_input_cubit/search_input_cubit.dart';
import 'package:rickest_app/shared/theme.dart';

class FlexSpaceBar extends StatefulWidget {
  @override
  _FlexSpaceBarState createState() => _FlexSpaceBarState();
}

class _FlexSpaceBarState extends State<FlexSpaceBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputCubit = context.watch<SearchInputCubit>();
    return FlexibleSpaceBar(
      titlePadding: EdgeInsets.only(bottom: 5),
      centerTitle: true,
      title: inputCubit.state
          ? Container(
              height: 30,
              width: ScreenUtil().setWidth(kSpacingUnit * 20),
              child: Column(children: [
                TextField(
                  controller: _textEditingController,
                  onSubmitted: (text) {
                    if (text != '') {
                      context.read<SearchEpisodeCubit>().searchForEpisode(text);
                    }
                  },
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: kSpacingUnit * 1.3,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: "Search by episode name...",
                      hintStyle: TextStyle(fontSize: kSpacingUnit * 1.3),
                      border: InputBorder.none),
                ),
                SizedBox(height: 4),
                Container(
                    width: double.infinity,
                    height: 1,
                    color: Theme.of(context).iconTheme.color)
              ]),
            )
          : Container(),
      background: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: DecorationImage(
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.45)
                    : Colors.black.withOpacity(0.85),
                BlendMode.dstATop),
            image: AssetImage(
              'assets/background.png',
            ),
          ),
        ),
      ),
    );
  }
}
