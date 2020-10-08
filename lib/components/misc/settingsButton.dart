import 'package:flutter/material.dart';
import 'package:imperial_sheets/views/settingsView.dart';

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Settings'),
      leading: Icon(Icons.settings),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsView()))
      },
    );
  }
}