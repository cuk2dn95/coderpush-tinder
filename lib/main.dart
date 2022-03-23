import 'package:coderpush_tinder/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/di.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Injector.init(await SharedPreferences.getInstance());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coder push demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Navigator.defaultRouteName,
      onGenerateRoute: routeFactory,
    );
  }
}