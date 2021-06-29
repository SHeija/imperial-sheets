import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  final ThemeData defaultTheme = ThemeData(
      accentColor: Colors.blueGrey[200],
      primaryColor: Colors.blueGrey,
      indicatorColor: Colors.blueGrey,
      textTheme: TextTheme(headline6: TextStyle(fontSize: 17.0)));
  @override
  Widget build(BuildContext context) {
    bool darkMode = Hive.box('settings').get('Dark mode', defaultValue: false);
    if (!darkMode && SchedulerBinding.instance.window.platformBrightness == Brightness.light) {
      StatusBar.color(Colors.blueGrey);
    }
    return MaterialApp(
      title: 'Imperial Sheets',
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
      darkTheme: ThemeData.dark(),
      theme: darkMode ? ThemeData.dark() : defaultTheme,
      home: HiveProvider(
        child: RootView(),
      ),
    );
  }
}
