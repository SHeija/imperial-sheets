import 'package:flutter/material.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import 'package:statusbar/statusbar.dart';
import './views/rootView.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    StatusBar.color(Colors.blueGrey);

    return MaterialApp(
      title: 'Imperial Sheets',
      theme: ThemeData(
        accentColor: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
      ),
      home: ChangeNotifierProvider(
        create: (context) => CharacterModel(),
        child: RootView(),
      ),
    );
  }
}