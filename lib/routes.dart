
import 'package:coderpush_tinder/presentation/screens/home.dart';
import 'package:coderpush_tinder/presentation/screens/liked_list.dart';
import 'package:coderpush_tinder/presentation/screens/second_look.dart';
import 'package:flutter/material.dart';

abstract class RoutePaths {
  static const homeScreen = Navigator.defaultRouteName;
  static const likedListRoute = 'LikedList';
  static const secondLookRoute = 'SecondLook';
}

Route<dynamic> routeFactory(RouteSettings settings) {
  switch (settings.name) {
    case RoutePaths.homeScreen:
      return _wrapper<dynamic>(const HomeScreen());
    case RoutePaths.likedListRoute:
      return _wrapper<dynamic>(const LikedListScreen());
    case RoutePaths.secondLookRoute:
      return _wrapper<dynamic>(const SecondLookScreen());
    default:
      return MaterialPageRoute<dynamic>(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Column(children: [
                const Text('Something error, back to home'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RoutePaths.homeScreen, (route) => false);
                    },
                    child: const Text('Home'))
              ]),
            ),
          );
        },
      );
  }
}

MaterialPageRoute<T> _wrapper<T>(Widget widget,
        {RouteSettings? setting, bool maintainState = true}) =>
    MaterialPageRoute(
        builder: (_) => widget,
        settings: setting,
        maintainState: maintainState);
