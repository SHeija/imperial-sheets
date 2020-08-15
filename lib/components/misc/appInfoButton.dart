import 'package:flutter/material.dart';

class AppInfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.info_outline),
      title: Text('Version'),
      subtitle: Text('0.0.3'),
    );
  }
}