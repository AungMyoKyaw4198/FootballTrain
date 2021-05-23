import 'package:FootballHighlightsApp/screens/home.dart';
import 'package:FootballHighlightsApp/screens/league_screen.dart';
import 'package:FootballHighlightsApp/util/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Train',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        Routes.home: (context) => Home(),
        Routes.lague: (context) => LeagueScreen(),
      },
    );
  }
}

