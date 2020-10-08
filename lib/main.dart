import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statusbar/statusbar.dart';
import './views/rootView.dart';
import 'models/character.dart';
import 'database/characterAdapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(CharacterAdapter());
  await Hive.openBox<Character>('characters');
  await Hive.openBox('settings');
  runApp(App());
}

class App extends StatelessWidget {
  ThemeData defaultTheme = ThemeData(
      accentColor: Colors.blueGrey[200],
      primaryColor: Colors.blueGrey,
      indicatorColor: Colors.blueGrey,
      textTheme: TextTheme(headline6: TextStyle(fontSize: 17.0)));
  @override
  Widget build(BuildContext context) {
    bool darkMode = Hive.box('settings').get('Dark mode', defaultValue: false);
    if (!darkMode) {
      StatusBar.color(Colors.blueGrey);
    }
    return MaterialApp(
      title: 'Imperial Sheets',
      darkTheme: darkMode ? ThemeData.dark() : defaultTheme,
      theme: defaultTheme,
      home: HiveProvider(
        child: RootView(),
      ),
    );
  }
}
