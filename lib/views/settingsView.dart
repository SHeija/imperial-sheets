import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class SettingsView extends StatelessWidget {
  // HiveProvider doesn't reach this class for whatever reason
  final Box settings = Hive.box('settings');

  List<Widget> _getTilesFromMap(Map<dynamic, dynamic> map) {
    List<Widget> list = [];
    map.forEach((key, value) {
      if (value.runtimeType == bool && key != 'initialized') {
        list.add(SwitchListTile(
            title: Text(key.toString()),
            value: value,
            onChanged: (bool value) {
              settings.put(key, value);
            }));
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ValueListenableBuilder(
        valueListenable: settings.listenable(),
        builder: (context, box, widget) {
          Map<dynamic, dynamic> settings = box.toMap();
          return ListView(
            padding: EdgeInsets.all(8.0),
            children: _getTilesFromMap(settings),
          );
        },
      ),
    );
  }
}
