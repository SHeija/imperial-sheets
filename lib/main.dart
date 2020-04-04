import 'package:flutter/material.dart';
import './views/myHomePage.dart';
import './views/readFileScreen.dart';
import './views/rootView.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imperial Sheets',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.red,
      ),
      home: RootView(),
    );
  }
}