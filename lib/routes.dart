import 'package:coderpush_tinder/screens/home.dart';
import 'package:flutter/material.dart';

class RoutePaths {}

Route<dynamic> routeFactory(RouteSettings settings) {
  switch (settings.name) {
    case Navigator.defaultRouteName:
      return _wrapper<dynamic>(const HomeScreen());
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
                          Navigator.defaultRouteName, (route) => false);
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
