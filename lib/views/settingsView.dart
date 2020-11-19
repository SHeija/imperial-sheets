import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:imperial_sheets/components/misc/appInfoButton.dart';
import 'package:imperial_sheets/components/misc/tutorial.dart';

class SettingsView extends StatelessWidget {
  // HiveProvider doesn't reach this class for whatever reason
  final Box settings = Hive.box('settings');

  Future<void> _showTutorial(BuildContext context) async {
    await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Tutorial();
      },
    );
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
          return ListView(padding: EdgeInsets.all(8.0), children: <Widget>[
            SwitchListTile(
              title: Text('Automatically calculate spent exp'),
              value: box.get('Auto exp calculation'),
              onChanged: (bool v) {
                box.put('Auto exp calculation', v);
              },
            ),
            SwitchListTile(
              title: Text('Display \"last edited\" timestamp'),
              value: box.get('Display editing timestamps'),
              onChanged: (bool v) {
                box.put('Display editing timestamps', v);
              },
            ),
            SwitchListTile(
              title: Text('Dark mode'),
              subtitle: Text(
                  'If unchecked, app follows system theme. Requires app restart.'),
              value: box.get('Dark mode'),
              onChanged: (bool v) {
                box.put('Dark mode', v);
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                _showTutorial(context);
              },
            ),
            AppInfoButton(),
          ]);
        },
      ),
    );
  }
}
